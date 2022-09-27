#!bin/basoh
echo "========== PART 3: PageRank =========="
USER_NAME=$1
echo ">> Username: ${USER_NAME}"

# hdfs cluster is read-only in safe-mode. So leave safe-mode
hdfs dfsadmin -safemode leave
echo ">> Left safe-mode"

# make work directory
NAMENODE_DIR=hdfs://10.10.1.1:9000/user/${USERNAME}/part3/
hadoop fs -mkdir -p ${NAMENODE_DIR}
echo ">> Directory made: ${NAMENODE_DIR}"

# save stats before run
if [ ! -d "log" ]; then
	mkdir log
	echo ">> DIrectory made: log"
fi

TASK=task_2_3
echo -e "===== [BEFORE] Network Stat - namenode =====" >> log/${TASK}_namenode.stat
cat /proc/net/dev >> log/${TASK}_namenode.stat
echo -e "\n\n===== [BEFORE] Disk Stat - namenode =====" >> log/${TASK}_namenode.stat
cat /proc/diskstats >> log/${TASK}_namenode.stat

echo -e "===== [BEFORE] Network Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
ssh node1 cat /proc/net/dev >> log/${TASK}_datanode1.stat
echo -e "\n\n===== [BEFORE] Disk Stat - datanode1 =====" >> log/${TASK}_datnode1.stat
ssh node1 cat /proc/diskstats >> log/${TASK}_datanode1.stat

echo -e "===== [BEFORE] Network Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
ssh node2 cat /proc/net/dev >> log/${TASK}_datanode2.stat
echo -e "\n\n===== [BEFORE] Disk Stat - datanode2 =====" >> log/${TASK}_datnode2.stat
ssh node2 cat /proc/diskstats >> log/${TASK}_datanode2.stat

# ==========
# run
# ==========
# put local file to hdfs
echo ">> Running"
if ! [[ -e "web-BerkStan.txt" ]]; then
	DOWNLOAD_URL=https://snap.stanford.edu/data/web-BerkStan.txt.gz
	echo "downloading: ${DOWNLOAD_URL}"
	wget ${DOWNLOAD_URL}
	gzip -d web-BerkStan.txt
	# remove gz
	rm web-BerkStan.txt.gz
fi
hdfs dfs -put web-BerkStan.txt ${NAMENODE_DIR}/web-BerkStan.txt
hadoop fs -ls ${NAMENODE_DIR}/

# run python
for ((cache=0; cache<1;cache++)); do
	for ((i=0;i<8;i++)); do
		num_partitions=$((2**i))
		echo ">> cache=${cache}, num_partitions=${num_partitions}"
		../../../spark-3.3.0-bin-hadoop3/bin/spark-submit --master spark://10.10.1.1:7077 --class "PageRank" task_2_3.py ${NAMENODE_DIR}/web-BerkStan.txt ${NAMENODE_DIR}/output_${cache}_${num_partitions} 10 $num_partitions $cache
	break
	done
	break
done



TASK=task$2
echo -e "\n\n===== [AFTER] Network Stat - namenode =====" >> log/${TASK}_namenode.stat
cat /proc/net/dev >> log/${TASK}_namenode.stat
echo -e "\n\n===== [AFTER] Disk Stat - namenode =====" >> log/${TASK}_namenode.stat
cat /proc/diskstats >> log/${TASK}_namenode.stat

echo -e "\n\n===== [AFTER] Network Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
ssh node1 cat /proc/net/dev >> log/${TASK}_datanode1.stat
echo -e "\n\n===== [AFTER] Disk Stat - datanode1 =====" >> log/${TASK}_datnode1.stat
ssh node1 cat /proc/diskstats >> log/${TASK}_datanode1.stat

echo -e "\n\n===== [AFTER] Network Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
ssh node2 cat /proc/net/dev >> log/${TASK}_datanode2.stat
echo -e "\n\n===== [AFTER] Disk Stat - datanode2 =====" >> log/${TASK}_datnode2.stat
ssh node2 cat /proc/diskstats >> log/${TASK}_datanode2.stat


echo ">> DONE =============================="
echo ">> Outputs at: ${NAMENODE_DIR}"
