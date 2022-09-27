#!bin/basoh
echo "========== PART 3: PageRank =========="
USER_NAME=$1
DATA=$2
echo ">> Username: ${USER_NAME}"
echo ">> Data: ${DATA}"

if [[ "$2" != "web-BerkStan" ]] && [[ "$2" != "enwiki-pages-articles" ]]; then
	echo "Usage: ./run.sh [user name] [web-BerkStan or enwiki-pages-articles]"
	exit 1
fi

# hdfs cluster is read-only in safe-mode. So leave safe-mode
hdfs dfsadmin -safemode leave
echo ">> Left safe-mode"

# make work directory
NAMENODE_DIR=hdfs://10.10.1.1:9000/user/${USERNAME}/part3/${DATA}
hadoop fs -mkdir -p ${NAMENODE_DIR}
echo ">> Directory made: ${NAMENODE_DIR}"

# save stats before run
if [ ! -d "log" ]; then
	mkdir log
	echo ">> DIrectory made: log"
fi

TASK=task_${DATA}
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
if [ "$2" = "web-BerkStan" ]; then
       if ! [[ -e "web-BerkStan" ]]; then
		DOWNLOAD_URL=https://snap.stanford.edu/data/web-BerkStan.txt.gz
		echo "downloading: ${DOWNLOAD_URL}"
		wget ${DOWNLOAD_URL}
		gzip -d web-BerkStan.txt
		# remove gz
		rm web-BerkStan.txt.gz
	fi

	hdfs dfs -put web-BerkStan.txt ${NAMENODE_DIR}/web-BerkStan.txt
	hadoop fs -ls ${NAMENODE_DIR}/
else
	hdfs dfs -put /proj/uwmadison744-f22-PG0/data-part3/enwiki-pages-articles/ ${NAMENODE_DIR}/enwiki-pages-articles
fi

# run python
if [ "$2" = "web-BerkStan" ]; then
	DATA_PATH=$2.txt
fi

for ((cache=0; cache<1;cache++)); do
	for ((i=0;i<8;i++)); do
		num_partitions=$((2**i))
		echo ">> cache=${cache}, num_partitions=${num_partitions}"
		hadoop fs -rm -r -f ${NAMENODE_DIR}/output_${DATA}_${cache}_${num_partitions}
		../../../spark-3.3.0-bin-hadoop3/bin/spark-submit --master spark://10.10.1.1:7077 --class "PageRank" task_2_3.py ${NAMENODE_DIR}/${DATA_PATH} ${NAMENODE_DIR}/output_${DATA}_${cache}_${num_partitions} 10 $num_partitions $cache
	done
done


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
