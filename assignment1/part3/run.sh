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
NAMENODE_DIR=hdfs://10.10.1.1:9000/users/${USER_NAME}/part3/${DATA}
# hadoop fs -rm -r ${NAMENODE_DIR}
hadoop fs -mkdir -p ${NAMENODE_DIR}
echo ">> Directory made: ${NAMENODE_DIR}"

# save stats before run
if [ ! -d "log" ]; then
	mkdir log
	echo ">> DIrectory made: log"
fi

# ==========
# run
# ==========
# put local file to hdfs
echo ">> Running $2"
if [ "$2" = "web-BerkStan" ]; then
 #      if ! [[ -e "web-BerkStan" ]] || 1 ; then
		DOWNLOAD_URL=https://snap.stanford.edu/data/web-BerkStan.txt.gz
		echo "downloading: ${DOWNLOAD_URL}"
		wget ${DOWNLOAD_URL}
		gzip -d web-BerkStan.txt
		# remove gz
		rm web-BerkStan.txt.gz
#	fi

	echo "Putting data to hdfs: ${NAMENODE_DIR}"
	hdfs dfs -put web-BerkStan.txt ${NAMENODE_DIR}/web-BerkStan.txt
	echo "  done"
else
	echo "Putting data to hdfs"
	hdfs dfs -put /proj/uwmadison744-f22-PG0/data-part3/enwiki-pages-articles/ ${NAMENODE_DIR}/enwiki-pages-articles
	echo "  done"
fi
mkdir "log_py"
hadoop fs -ls ${NAMENODE_DIR}

# run python
if [ "$2" = "web-BerkStan" ]; then
	DATA_PATH=$2.txt
else
	DATA_PATH=$2
fi

for ((cache=1; cache>=0;cache--)); do
	for ((i=8;i>=0;i--)); do
		num_partitions=$((2**i))
		if [ ${num_partitions} != 16 ]; then
			echo "Skipping num_partitions=${num_partitions}"
			continue
		fi
		if [ ${cache} != 1 ]; then
			echo "Skipping cache=${cache}"
			continue
		fi
		SAVE_DIR=${NAMENODE_DIR}/output_${DATA}_${cache}_${num_partitions}
	
		hadoop fs -rm -r ${SAVE_DIR}
		hadoop fs -mkdir -p ${SAVE_DIR}
		echo ">> cache=${cache}, num_partitions=${num_partitions}"
		echo ">> saving to: ${SAVE_DIR}"
		
		# log disk/network
		TASK=task_${cache}_${num_partitions}
		echo -e "===== [BEFORE] Network Stat - namenode =====" >> log/${TASK}_namenode.stat
		cat /proc/net/dev >> log/${TASK}_namenode.stat
		echo -e "\n\n===== [BEFORE] Disk Stat - namenode =====" >> log/${TASK}_namenode.stat
		cat /proc/diskstats >> log/${TASK}_namenode.stat

		echo -e "===== [BEFORE] Network Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
		ssh node1 cat /proc/net/dev >> log/${TASK}_datanode1.stat
		echo -e "\n\n===== [BEFORE] Disk Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
		ssh node1 cat /proc/diskstats >> log/${TASK}_datanode1.stat

		echo -e "===== [BEFORE] Network Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
		ssh node2 cat /proc/net/dev >> log/${TASK}_datanode2.stat
		echo -e "\n\n===== [BEFORE] Disk Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
		ssh node2 cat /proc/diskstats >> log/${TASK}_datanode2.stat
		
		# run python script
		hadoop fs -rm -r -f ${SAVE_DIR}
		
		echo "cache: $cache"
		if [ $cache != 0 ]; then 
			../../../spark-3.3.0-bin-hadoop3/bin/spark-submit --master spark://10.10.1.1:7077 --class "PageRank" --executor-memory 1G tasks.py ${NAMENODE_DIR}/${DATA_PATH} ${SAVE_DIR} 10 $num_partitions $cache
		else
			../../../spark-3.3.0-bin-hadoop3/bin/spark-submit --master spark://10.10.1.1:7077 --class "PageRank" --executor-memory 30G tasks.py ${NAMENODE_DIR}/${DATA_PATH} ${SAVE_DIR} 10 $num_partitions $cache
		fi
		# log disk/network
		echo -e "\n\n===== [AFTER] Network Stat - namenode =====" >> log/${TASK}_namenode.stat
		cat /proc/net/dev >> log/${TASK}_namenode.stat
		echo -e "\n\n===== [AFTER] Disk Stat - namenode =====" >> log/${TASK}_namenode.stat
		cat /proc/diskstats >> log/${TASK}_namenode.stat

		echo -e "\n\n===== [AFTER] Network Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
		ssh node1 cat /proc/net/dev >> log/${TASK}_datanode1.stat
		echo -e "\n\n===== [AFTER] Disk Stat - datanode1 =====" >> log/${TASK}_datanode1.stat
		ssh node1 cat /proc/diskstats >> log/${TASK}_datanode1.stat

		echo -e "\n\n===== [AFTER] Network Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
		ssh node2 cat /proc/net/dev >> log/${TASK}_datanode2.stat
		echo -e "\n\n===== [AFTER] Disk Stat - datanode2 =====" >> log/${TASK}_datanode2.stat
		ssh node2 cat /proc/diskstats >> log/${TASK}_datanode2.stat

		
		# download files from hdfs to local
		#hadoop fs -copyToLocal  ${SAVE_DIR} ./
		#echo "Downloaded to namenode: ${SAVE_DIR}"
		#hadoop fs -rm -r ${SAVE_DIR}
		#echo "Removed save dir ${SAVE_DIR}"
		
	done
done


echo ">> DONE =============================="
echo ">> Outputs at: ${NAMENODE_DIR}"
