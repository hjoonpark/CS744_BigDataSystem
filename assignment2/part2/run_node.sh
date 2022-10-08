#!/bin/bash
RANK=$1
echo "RANK=${RANK}"

# ip of the root
MASTER_IP=10.10.1.1
NUM_NODES=4

# make output directories for each of the nodes
# root node: 0
cd ~ 
# worker nodes: 1, 2, 3
ROOT_DIR="/users/hpark376/CS744_BigDataSystem/assignment2/part2"
mkdir -p ${ROOT_DIR}/output

# use python from conda
PYTHON_DIR="/users/hpark376/miniconda3/bin/"
# CMD_PATH="export PATH=\"/users/hpark376/miniconda3/bin:\$PATH\""

# run script for current node
echo "running for root node"
python ${ROOT_DIR}/main.py --master-ip $MASTER_IP --num-nodes $NUM_NODES --rank ${RANK} >> ${ROOT_DIR}/output/log_rank${RANK}.txt

echo "==== DONE ===="
