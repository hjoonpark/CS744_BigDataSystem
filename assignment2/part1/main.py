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
import time
import sys
sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
from logger import Logger

device = "cpu"
torch.set_num_threads(4)
batch_size = 256 # batch for one node

def train_model(model, epoch, input_data, target_data, optimizer, criterion):
    optimizer.zero_grad()
    # ==================================================================================== #
    # standard way of forward + backward + optimize
    outputs = model(input_data)
    loss = criterion(outputs, target_data)
    # ==================================================================================== #
    loss.backward()
    optimizer.step()
    return loss

def test_model(model, test_loader, criterion, logger):
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
    logger.print("Test average={} accuracy={}/{}={}".format(test_loss, correct, len(test_loader.dataset), 100*correct/len(test_loader.dataset)))

def main():
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
    log_path = os.path.join(save_dir, "part1_rank{}.txt".format(rank))
    logger = Logger(log_path)
    
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
    train_set = datasets.CIFAR10(root="./data", train=True, download=True, transform=transform_train)
    train_loader = torch.utils.data.DataLoader(train_set, num_workers=2, batch_size=batch_size, sampler=None, shuffle=True, pin_memory=True)
    test_set = datasets.CIFAR10(root="./data", train=False, download=True, transform=transform_test)

    test_loader = torch.utils.data.DataLoader(test_set, num_workers=2, batch_size=batch_size, shuffle=False, pin_memory=True)
    criterion = torch.nn.CrossEntropyLoss().to(device)

    model = mdl.VGG11()
    model.to(device)

    optimizer = optim.SGD(model.parameters(), lr=0.1, momentum=0.9, weight_decay=0.0001)

    logger.print(model)
    logger.print("args={}".format(args))
    logger.print("device={}".format(device))
    logger.print("tr={} te={} batch_size={}".format(len(train_set), len(test_set), batch_size))
    
    # running training for one epoch
    dt = 0
    n_iter = 0
    for epoch in range(1):
        running_loss = 0
        for batch_idx, (input_data, target_data) in enumerate(train_loader):
            t0 = time.time()
            loss = train_model(model, epoch, input_data, target_data, optimizer, criterion)
            dt += (t0-time.time())
            n_iter += 1

            running_loss += loss.item()
            if batch_idx % 20 == 19:    # print every 20 mini-batches
                logger.print("rank={} epoch={} batch_idx={} loss={}".format(rank, epoch, batch_idx, running_loss/20))
                running_loss = 0.0

            if n_iter >= 40:
                break
    dt /= n_iter
    logger.print("dt={} n_iter={}".format(dt, n_iter))
    # train is over

    # test
    test_model(model, test_loader, criterion, logger)

if __name__ == "__main__":
    # [IMPORTANT] set seeds
    torch.manual_seed(0)
    random.seed(0)
    np.random.seed(0)

    main()