#!/bin/bash

# ip of the root
IP_ADDR=$(hostname -I)
IP=(${IP_ADDR//" "//})
echo "IP: ${IP}"

MASTER_IP=10.10.1.1
NUM_NODES=4

# make output directories for each of the nodes
# root node: 0
cd ~ 
# worker nodes: 1, 2, 3
ROOT_DIR="/users/hpark376/CS744_BigDataSystem/assignment2/part2"
mkdir -p ${ROOT_DIR}/output
ssh node1 mkdir -p ${ROOT_DIR}/output
ssh node2 mkdir -p ${ROOT_DIR}/output
ssh node3 mkdir -p ${ROOT_DIR}/output

# use python from conda
PYTHON_DIR="/users/hpark376/miniconda3/bin/"

# run script for each node
# root node: 0
echo "running for root node"
python ${ROOT_DIR}/main.py --master-ip $MASTER_IP --num-nodes $NUM_NODES --rank 0 >> ${ROOT_DIR}/output/log_rank0.txt

# needs to set path for conda in each node
CMD_PATH="export PATH=\"/users/hpark376/miniconda3/bin:\$PATH\""
# nodes: 1, 2, 3
for NODE_IDX in 1 2 3; do
	#break;
    echo "=================================================== "
    echo "  - running for node ${NODE_IDX}"

    # needs to set path for conda
    ssh node$NODE_IDX "$CMD_PATH; echo \"PATH=$PATH\";"
    
    touch ${ROOT_DIR}/output/log_rank${NODE_IDX}.txt
    ssh node$NODE_IDX "${PYTHON_DIR}/python ${ROOT_DIR}/main.py --master-ip $MASTER_IP --num-nodes $NUM_NODES --rank $NODE_IDX >> ${ROOT_DIR}/output/log_rank${NODE_IDX}.txt"
done

echo "==== DONE ===="
