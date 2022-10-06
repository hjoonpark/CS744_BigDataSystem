# Part 3: PageRank

To run the page rank algorithm, use the following command:

    bash run.sh [user_name] [data_name]
    
For example,

    [user_name] = hpark376
    [data_name] = web-BerkStan or enwiki-pages-articles

The executions run each of [1, 2, 4, 8, 16, 32, 64, 128, 256] number of partitions and [True, False] for caching option (i.e., total of 9x2=18 independent executions).

Running `run.sh` will execute `part3.py` for **task 1, 2, and 3**. For **task 4**, we manually kill a datanode process in terminal using PID
obtained from the following command in namenode:

    ps -ef | grep sparks
    sudo kill -9 [PID]
