import os
import torch
import json
import copy
import numpy as np
import argparse
from torchvision import datasets, transforms
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import logging
import random
import model as mdl
import torch.distributed as dist
device = "cpu"
torch.set_num_threads(4)

batch_size = 256 # batch for one node

def test_model(model, test_loader, criterion):
    model.eval()
    test_loss = 0
    correct = 0
    with torch.no_grad():
        for batch_idx, (data, target) in enumerate(test_loader):
            data, target = data.to(device), target.to(device)
            output = model(data)
            test_loss += criterion(output, target)
            pred = output.max(1, keepdim=True)[1]
            correct += pred.eq(target.view_as(pred)).sum().item()

    test_loss /= len(test_loader)
    print('Test set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
            test_loss, correct, len(test_loader.dataset),
            100. * correct / len(test_loader.dataset)))

def train_model(model, train_loader, optimizer, criterion, epoch):
    """
    model (torch.nn.module): The model created to train
    train_loader (pytorch data loader): Training data loader
    optimizer (optimizer.*): A instance of some sort of optimizer, usually SGD
    criterion (nn.CrossEntropyLoss) : Loss function used to train the network
    epoch (int): Current epoch number
    """
    # collect gradients
    gradients = []

    running_loss = 0
    # remember to exit the train loop at end of the epoch
    for batch_idx, (data, target) in enumerate(train_loader):
        # zero the parameter gradients
        optimizer.zero_grad()

        # forward + backward + optimize
        outputs = model(data)
        loss = criterion(outputs, target)
        loss.backward()

        # accumulate gradients
        for p in model.parameters():
            gradients.append(p.grad)

        optimizer.step()

        running_loss += loss.item()
        if batch_idx % 20 == 19:    # print every 20 mini-batches
            print('epoch:', epoch, 'batch num:', batch_idx, 'loss:', running_loss/20)
            running_loss = 0.0
    return gradients

def test_model(model, test_loader, criterion):
    model.eval()
    test_loss = 0
    correct = 0
    with torch.no_grad():
        for batch_idx, (data, target) in enumerate(test_loader):
            data, target = data.to(device), target.to(device)
            output = model(data)
            test_loss += criterion(output, target)
            pred = output.max(1, keepdim=True)[1]
            correct += pred.eq(target.view_as(pred)).sum().item()

    test_loss /= len(test_loader)
    print('Test set: Average loss: {:.4f}, Accuracy: {}/{} ({:.0f}%)\n'.format(
            test_loss, correct, len(test_loader.dataset),
            100. * correct / len(test_loader.dataset)))
            

def main():
    parser = argparse.ArgumentParser(description='Distributed PyTorch Training')
    parser.add_argument('--master-ip', default='10.10.1.1', type=str, metavar='N',help='manual ip number', dest='master_ip')
    parser.add_argument('--num-nodes', default=4, type=int, help='number of nodes for distributed training', dest='num_nodes')
    parser.add_argument('--rank', default=0, type=int, help='node rank for distributed training')
    args = parser.parse_args()
    print("args: {}".format(args))

    rank = args.rank
    """
    torch.distributed.init_process_group() parameters
    - backend: 
        - "gloo": Gloo (for CPU)
        - "nccl": NCCL (for GPU)
        - "mpi": for some special cases?
    - init_method: URL specifying how to initialize the process group. Default is "env://"
    - world_size: Number of processes participating in the job
    - rank: Rank of the current process (it should be a number between 0 and world_size-1)
    """
    init_method = "tcp://{}:6666".format(args.master_ip)
    print("init_method: {}".format(init_method))
    dist.init_process_group(backend="gloo", init_method=init_method, world_size=args.num_nodes, rank=args.rank)

    # preprocessing dataset
    normalize = transforms.Normalize(mean=[x/255.0 for x in [125.3, 123.0, 113.9]],
                                std=[x/255.0 for x in [63.0, 62.1, 66.7]])
    transform_train = transforms.Compose([
            transforms.RandomCrop(32, padding=4),
            transforms.RandomHorizontalFlip(),
            transforms.ToTensor(),
            normalize,
        ])

    transform_test = transforms.Compose([
            transforms.ToTensor(),
            normalize])
    
    # load train set
    train_set = datasets.CIFAR10(root="./data", train=True, download=True, transform=transform_train)
    train_loader = torch.utils.data.DataLoader(train_set, num_workers=2, batch_size=batch_size, sampler=None, shuffle=True, pin_memory=True)

    # load test set
    test_set = datasets.CIFAR10(root="./data", train=False, download=True, transform=transform_test)
    test_loader = torch.utils.data.DataLoader(test_set, num_workers=2, batch_size=batch_size, shuffle=False, pin_memory=True)

    print("train_set: {}, test_set: {}".format(len(train_set), len(test_set)))
    criterion = torch.nn.CrossEntropyLoss().to(device)

    model = mdl.VGG11()
    model.to(device)
    print(model)
    print("device: {}".format(device))

    optimizer = optim.SGD(model.parameters(), lr=0.1, momentum=0.9, weight_decay=0.0001)

    # process group
    group = dist.group.WORLD
    group_size = args.num_nodes

    # running training for one epoch
    for epoch in range(1):
        print(">> epoch {}".format(epoch))
        # each batch is divided into processors (nodes), and averaged gradient sent back to each node for respective back-propagation
        # we first send the gradients of the 3 nodes to the root node, average them, and then send them to the 3 nodes respectively.
        for batch_idx, (data, target) in enumerate(train_loader):
            # zero the parameter gradients
            optimizer.zero_grad()

            # forward + backward + optimize
            outputs = model(data)
            loss = criterion(outputs, target)
            
            # compute gradient
            loss.backward() 

            # average gradients across nodes if current node is not root (rank=0)
            print("epoch {} | rank={}, group={}".format(epoch, rank, group))
            if rank == 0:
                # current node is root
                for params in model.parameters():
                    # list to hold gradient from each of the nodes
                    grads_from_nodes = [torch.zeros_like(params.grad) for _ in range(group_size)]

                    # Gathers a list of tensors in a single process: gather gradients from other nodes
                    dist.gather(params.grad, gather_list=grads_from_nodes, group=group, async_op=False)

                    # average the gradients
                    avg_grad = torch.zeros_like(params.grad)
                    for node_idx in range(group_size):
                        avg_grad = torch.add(avg_grad, grads_from_nodes[node_idx])
                    avg_grad = torch.divide(avg_grad, group_size)

                    # Scatters a list of tensors to all processes in a group: scatter back to nodes
                    dist.scatter(avg_grad, group=group)
            else:
                # current node is one of the workers
                # The worker node first sends its gradient to the root node, and then receives the averaged gradient calculated by the root node.
                for params in model.parameters():
                    # send gradient to root (rank=0)
                    dist.gather(params.grad, group=group, async_op=False)
                    # receive back the gradient from root
                    dist.scatter(params.grad, src=0, group=group, async_op=False)

            # back-propagate
            optimizer.step()

            running_loss += loss.item()
            if batch_idx % 20 == 19:    # print every 20 mini-batches
                print('epoch:', epoch, 'batch num:', batch_idx, 'loss:', running_loss/20)
                running_loss = 0.0
                
        gradients = train_model(model, train_loader, optimizer, training_criterion, epoch)
        test_model(model, test_loader, training_criterion)

        # for each gradient of model parameters
        gradients_new = []
        for grad in gradients:
            gathered_grads = [torch.zeros_like(grad) for _ in range(args.num_nodes)]

            # GATHER
            """
            torch.distributed.gather()
            - tensor: Input tensor
            - gather_list: List of appropriately-sized tensors to use for gathered data (default is None, must be specified on the destination rank)
            - dst: Destination rank (default is 0)
            - group: The process group to work on. If None, the default process group will be used.
            - async_op: Whether this op should be an async op
            """
            if rank == 0:
                # current device is the root node, so gather from other nodes
                dist.gather(tensor, gather_list=gathered_grads)
            else:
                # gather from other nodes
                gather(tensor=grad, rank=rank, tensor_list=grad_list)

            # GATHER: compute average gradient
            if rank == 0:
                grad_sum = torch.zeros_like(grad)
                for group_idx in range(len(grad_list)):
                    grad_sum = torch.add(grad_sum, grad_list[group_idx])
                grad_mean = torch.divide(grad_sum, len(grad_list))
            else:
                grad_mean = torch.zeros_like(grad)
        
            # SCATTER
            dist.scatter(grad_mean, group=dist.group.WORLD)

            # append to new gradients
            gradients_new.append(grad_mean)
    # train is over

    # test
    # test_models(model, test_loader, training_criterion)

def gather(tensor, rank, tensor_list=None, root=0, group=None):
    """
    sends tensor to root process, which stores it in tensor_list
    """
    if group is None:
        group = dist.group.WORLD
    
    if rank == 0:
        dist.gather(tensor, gather_list=tensor_list, group=group)
    else:
        dist.gather(tensor, dst=root, group=group)

if __name__ == "__main__":
    main()
