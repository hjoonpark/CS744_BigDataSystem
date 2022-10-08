# append node0's ssh key to node 1 and 2
# node0
# cat ~/.ssh/id_rsa.pub

# node 1, 2
# vim ~/.ssh/authorized_keys

# rm hosts
rm hosts
echo "node1.agn2-g18.uwmadison744-f22-pg0.clemson.cloudlab.us" >> hosts
echo "node2.agn2-g18.uwmadison744-f22-pg0.clemson.cloudlab.us" >> hosts
echo "node3.agn2-g18.uwmadison744-f22-pg0.clemson.cloudlab.us" >> hosts
cat hosts

# check if connection is working in node0
parallel-ssh -i -h hosts -O StrictHostKeyChecking=no pwd

# for spark
echo "10.10.1.2" >> /users/hpark376/spark-3.3.0-bin-hadoop3/conf/workers.template
echo "10.10.1.3" >> /users/hpark376/spark-3.3.0-bin-hadoop3/conf/workers.template
sudo cp /users/hpark376/spark-3.3.0-bin-hadoop3/conf/workers.template /users/hpark376/spark-3.3.0-bin-hadoop3/conf/workers

# node0
# echo "export PATH=$PATH:/users/hpark376/hadoop-3.3.4/bin:/users/hpark376/hadoop-3.3.4/sbin" >> ~/.bashrc
# echo "export PATH=$PATH:/users/hpark376/hadoop-3.3.4/bin:/users/hpark376/hadoop-3.3.4/sbin" >> ~/.profile
# source ~/.profile
# source ~/.bashrc
# export PATH="$PATH:/users/hpark376/hadoop-3.3.4/bin"
# export PATH="$PATH:/users/hpark376/hadoop-3.3.4/sbin"
setenv PATH $PATH":/users/hpark376/hadoop-3.3.4/bin"
setenv PATH $PATH":/users/hpark376/hadoop-3.3.4/sbin"
printenv PATH

# start hadoop
start-dfs.sh

# start spark
/users/hpark376/spark-3.3.0-bin-hadoop3/sbin/start-all.sh


