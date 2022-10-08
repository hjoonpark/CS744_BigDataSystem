#!/bin/bash

# ip of the root
IP_ADDR=$(hostname -I)
IP=(${IP_ADDR//" "//})

MASTER_IP=10.10.1.1
NUM_NODES=4

# make output directories for each of the nodes
# root node: 0
cd ~
mkdir -p output
# worker nodes: 1, 2, 3
ROOT_DIR="/users/hpark376"
ssh node1 mkdir -p ${ROOT_DIR}/output
ssh node2 mkdir -p ${ROOT_DIR}/output
ssh node3 mkdir -p ${ROOT_DIR}/output

# run script for each node
# root node: 0
echo "running for root node"
python main.py --master-ip $MASTER_IP --num-nodes $NUM_NODES --rank 0 >> output/log_rank0.txt

# nodes: 1, 2, 3
for NODE_IDX in "1 2 3"; do
    echo "  - running for node ${NODE_IDX}"
    ssh  python main.py --master-ip $MASTER_IP --num-nodes $NUM_NODES --rank $NODE_IDX >> output/log_rank${NODE_IDX}.txt
done

echo "==== DONE ===="