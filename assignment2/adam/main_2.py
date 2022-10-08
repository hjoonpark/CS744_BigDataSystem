import os
import torch
import json
import copy
import numpy as np
from torchvision import datasets, transforms
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
import logging
import random
import model as mdl
import argparse
import torch.distributed as dist
device = "cpu"
torch.set_num_threads(4)

batch_size = 64 # batch for one node

parser = argparse.ArgumentParser(description='Distributed PyTorch Training')
parser.add_argument('--master-ip', default='10.0.0.1', type=str, metavar='N',help='manual ip number', dest='master_ip')
parser.add_argument('--num-nodes', default=-4, type=int, help='number of nodes for distributed training', dest='num_nodes')
parser.add_argument('--rank', default=-1, type=int, help='node rank for distributed training')

grads = []

def train_model(model, train_loader, optimizer, criterion, epoch):
    """
    model (torch.nn.module): The model created to train
    train_loader (pytorch data loader): Training data loader
    optimizer (optimizer.*): A instance of some sort of optimizer, usually SGD
    criterion (nn.CrossEntropyLoss) : Loss function used to train the network
    epoch (int): Current epoch number
    """
    running_loss = 0
    # remember to exit the train loop at end of the epoch
    for batch_idx, (data, target) in enumerate(train_loader):
        # zero the parameter gradients
        optimizer.zero_grad()
        # forward + backward + optimize
        outputs = model(data)
        loss = criterion(outputs, target)
        loss.backward()

        for p in model.parameters():
            grads.append(p.grad)

        optimizer.step()
        running_loss += loss.item()
        if batch_idx % 20 == 19:    # print every 2000 mini-batches
            #print(f'[{epoch + 1}, {batch_idx + 1:5d}] loss: {running_loss / 20:.3f}')
            print('epoch:', epoch, 'batch num:', batch_idx, 'loss:', running_loss/20)
            running_loss = 0.0


    return None

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
    args = parser.parse_args()
    ## INIT DIST ##
    ip = 'tcp://' + args.master_ip + ':6567'
    dist.init_process_group('gloo', init_method=ip, rank=args.rank, world_size=args.num_nodes)
    ## END INIT ##

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


    training_set = datasets.CIFAR10(root="./data", train=True,
                                                download=True, transform=transform_train)
    train_sampler = torch.utils.data.distributed.DistributedSampler(training_set)
    train_loader = torch.utils.data.DataLoader(training_set,
                                                    num_workers=2,
                                                    batch_size=batch_size,
                                                    sampler=train_sampler,
                                                    shuffle=False,
                                                    pin_memory=True)




    test_set = datasets.CIFAR10(root="./data", train=False,
                                download=True, transform=transform_test)
    test_sampler = torch.utils.data.distributed.DistributedSampler(test_set, shuffle=False, drop_last=True)
    test_loader = torch.utils.data.DataLoader(test_set,
                                              num_workers=2,
                                              batch_size=batch_size,
                                              shuffle=False,
                                              pin_memory=True,
                                              sampler=test_sampler)


    training_criterion = torch.nn.CrossEntropyLoss().to(device)

    model = mdl.VGG11()
    model.to(device)
    optimizer = optim.SGD(model.parameters(), lr=0.1,
                          momentum=0.9, weight_decay=0.0001)
    # running training for one epoch
    for epoch in range(1):
        train_sampler.set_epoch(epoch)

        train_model(model, train_loader, optimizer, training_criterion, epoch)

        new_grads = []

        for grad in grads:
            grad_list = [torch.zeros_like(grad) for _ in range(args.num_nodes)]

            # Gather gradients from other nodes
            if args.rank == 0:
                gather(grad, grad_list)
            else:
                gather(grad)

            # Compute average gradient
            if args.rank == 0:
                ave_grad = torch.divide(torch.add(torch.add(grad_list[0], grad_list[1]), torch.add(grad_list[2], grad_list[3])), 4)
            else:
                ave_grad = torch.zeros_like(grad)

            # Scatter back to nodes
            dist.scatter(ave_grad, group=dist.group.WORLD)

            # Append to new gradients
            new_grads.append(ave_grad)


        test_model(model, test_loader, training_criterion)


def gather(tensor, tensor_list=None, root=0, group=None):
    """
        Sends tensor to root process, which store it in tensor_list.
    """
    args = parser.parse_args()
    rank = args.rank
    if group is None:
        group = dist.group.WORLD
    if rank == 0:
        dist.gather(tensor, gather_list=tensor_list, group=group)
    else:
        dist.gather(tensor, dst=root, group=group)

if __name__ == "__main__":
    main()

                                                                            

