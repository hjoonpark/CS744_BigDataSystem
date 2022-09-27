USER_NAME="$1"

hadoop fs -rm -r hdfs://10.10.1.1:9000/users/${USER_NAME}/part2
hadoop fs -mkdir hdfs://10.10.1.1:9000/users
hadoop fs -mkdir hdfs://10.10.1.1:9000/users/${USER_NAME}
hadoop fs -mkdir hdfs://10.10.1.1:9000/users/${USER_NAME}/part2

# Check using
hdfs dfs -cat hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/export.csv

# download csv
rm export.csv*
wget http://pages.cs.wisc.edu/~shivaram/cs744-fa18/assets/export.csv

# Add local input file (export.csv) to hdfs
hdfs dfs -put export.csv hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/export.csv

# Check using
hdfs dfs -cat hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/export.csv

# run python
SPARK_DIR=/users/${USER_NAME}/spark-3.3.0-bin-hadoop3/bin
${SPARK_DIR}/spark-submit --master spark://10.10.1.1:7077 --class "SimpleSparkAppt" part2.py hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/export.csv hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/output.csv

# show result
echo "========== DONE =========="
hdfs dfs -ls hdfs://10.10.1.1:9000/users/${USER_NAME}/part2/output.csv
