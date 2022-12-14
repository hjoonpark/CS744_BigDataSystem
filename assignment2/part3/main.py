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
from torch.utils.data.distributed import DistributedSampler
import time

device = "cpu"
torch.set_num_threads(4)
group_list = []
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
    with open(f"{log_path}", "a+") as f:
        print("Test average={} accuracy={}/{}={}\n".format(test_loss, correct, len(test_loader.dataset), 100*correct/len(test_loader.dataset)))
        
def train_model(model, rank, epoch, train_loader, optimizer, criterion):
    group = dist.new_group(group_list)
    group_size = len(group_list)

    dt = 0
    n_iter = 0
    with open(f"{log_path}", "a+") as f:
        running_loss = 0
        for batch_idx, (input_data, target_data) in enumerate(train_loader):
            if rank == 0 and n_iter > 0:
                t0 = time.time()

            # ----- timing starts ---------------------------------------------------- #
            input_data, target_data = input_data.to(device), target_data.to(device)
            optimizer.zero_grad()
            outputs = model(input_data)
            loss = criterion(outputs, target_data)
            loss.backward()
            optimizer.step()
            # ----- timing starts ---------------------------------------------------- #

            if rank == 0 and n_iter > 0:
                dt += (time.time()-t0)
                
                running_loss += loss.item()
                if batch_idx % 20 == 19:    # print every 20 mini-batches
                    f.write("dt={:.2f} rank={} epoch={} batch_idx={} loss={}\n".format(dt, rank, epoch, batch_idx, running_loss/20))
                    running_loss = 0.0

            n_iter += 1
            if n_iter >= 40:
                break
        if rank == 0:
            dt /= (n_iter-1)
            f.write("dt={} per iteration. n_iter={}\n".format(dt, (n_iter-1)))

def main():
    global log_path
    # python main.py --master-ip $ip_address$ --num-nodes 4 --rank $rank$
    parser = argparse.ArgumentParser(description='Distributed PyTorch Training')
    parser.add_argument('--master-ip', default='10.10.1.1', type=str, metavar='N',help='manual ip number', dest='master_ip')
    parser.add_argument('--num-nodes', default=4, type=int, help='number of nodes for distributed training', dest='num_nodes')
    parser.add_argument('--rank', default=0, type=int, help='node rank for distributed training')
    args = parser.parse_args()

    rank = args.rank
    
    file_path = os.path.abspath(os.path.dirname(__file__))
    save_dir = os.path.join(file_path, "..", "output")
    os.makedirs(save_dir, exist_ok=True)
    log_path = os.path.join(save_dir, "part3_rank{}.txt".format(rank))

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
    # process group
    for group in range(0, args.num_nodes):
        group_list.append(group)

    init_method = "tcp://{}:6666".format(args.master_ip)
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
    batch_size = 256 // args.num_nodes
    train_set = datasets.CIFAR10(root="./data", train=True, download=True, transform=transform_train)
    sampler = DistributedSampler(train_set, seed=0) if torch.distributed.is_available() else None
    train_loader = torch.utils.data.DataLoader(train_set, num_workers=2, batch_size=batch_size, sampler=sampler, pin_memory=True)

    # load test set
    test_set = datasets.CIFAR10(root="./data", train=False, download=True, transform=transform_test)
    test_loader = torch.utils.data.DataLoader(test_set, num_workers=2, batch_size=batch_size, shuffle=False, pin_memory=True)

    criterion = torch.nn.CrossEntropyLoss().to(device)

    model = mdl.VGG11()
    
    model.to(device)

    # ==================================================================================== #
    # [PART 3] use pytorch's distributed functionality
    model = nn.parallel.DistributedDataParallel(model)
    # ==================================================================================== #

    optimizer = optim.SGD(model.parameters(), lr=0.1, momentum=0.9, weight_decay=0.0001)

    print("init_method={}".format(init_method))
    print("args={}".format(args))
    print("device={}".format(device))
    print("tr={} te={} batch_size={}".format(len(train_set), len(test_set), batch_size))

    # running training for one epoch
    for epoch in range(1):
        loss = train_model(model, rank, epoch, train_loader, optimizer, criterion)
    # train is over

    # test
    test_model(model, test_loader, criterion)

if __name__ == "__main__":
    # [IMPORTANT] set seeds
    torch.manual_seed(0)
    random.seed(0)
    np.random.seed(0)

    main()
