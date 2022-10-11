# Configuration

Open and run the commands line-by-line in `setup_root.sh` and `setup_worker.sh` to configure the root node and worker nodes, respectively. 

Put the hostnames of the three worker nodes inside the file `hosts`.

# Run

    bash run_part.sh <part-number> <number-of-nodes> <rank>

## Part 1
On the root node:

    bash run_part.sh 1 1 0

## Part 2a
On the root node:

    bash run_part.sh 2a 4 0

On the worker node `n`:

    bash run_part.sh 2a 4 n

## Part 2b
On the root node:

    bash run_part.sh 2b 4 0

On the worker node `n`:

    bash run_part.sh 2b 4 n


## Part 3
On the root node:

    bash run_part.sh 3 4 0

On the worker node `n`:

    bash run_part.sh 3 4 n


# Outputs

The reports of *average time per iteration* for each task will be saved to

    ./output/