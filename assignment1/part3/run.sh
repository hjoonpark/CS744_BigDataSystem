hpark376 14888     1  0 Sep26 ?        00:03:16 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Dproc_secondarynamenode -Djava.net.preferIPv4Stack=true -Dhdfs.audit.logger=INFO,NullAppender -Dhadoop.security.logger=INFO,RFAS -Dyarn.log.dir=/users/hpark376/hadoop-3.3.4/logs -Dyarn.log.file=h
hpark376 18256     1  0 Sep26 ?        00:02:54 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -cp /users/hpark376/spark-3.3.0-bin-hadoop3/conf/:/users/hpark376/spark-3.3.0-bin-hadoop3/jars/* -Xmx1g org.apache.spark.deploy.master.Master --host clnodevm094-1.clemson.cloudlab.us --port 7077 -
hpark376 22623     1  2 Sep27 ?        00:07:29 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Dproc_datanode -Djava.net.preferIPv4Stack=true -Dhadoop.security.logger=ERROR,RFAS -Dyarn.log.dir=/users/hpark376/hadoop-3.3.4/logs -Dyarn.log.file=hadoop-hpark376-datanode-node0.asgn1-group18.uw
root     24156     2  0 Sep27 ?        00:01:29 [kworker/0:0]
root     25528     2  0 Sep27 ?        00:00:21 [kworker/4:0]
hpark376 25848     1  0 Sep26 ?        00:23:24 /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java -Dproc_resourcemanager -Djava.net.preferIPv4Stack=true -Dservice.libdir=/users/hpark376/hadoop-3.3.4/share/hadoop/yarn,/users/hpark376/hadoop-3.3.4/share/hadoop/yarn/lib,/users/hpark376/hadoop-3.3
root     27755     2  0 Sep27 ?        00:00:00 [kworker/2:2]
node0:~/CS744_BigDataSystem/assignment1/part3> pwd
/users/hpark376/CS744_BigDataSystem/assignment1/part3
node0:~/CS744_BigDataSystem/assignment1/part3> hdfs
Usage: hdfs [OPTIONS] SUBCOMMAND [SUBCOMMAND OPTIONS]

  OPTIONS is none or any of:

--buildpaths                       attempt to add class files from build tree
--config dir                       Hadoop config directory
--daemon (start|status|stop)       operate on a daemon
--debug                            turn on shell script debug mode
--help                             usage information
--hostnames list[,of,host,names]   hosts to use in worker mode
--hosts filename                   list of hosts to use in worker mode
--loglevel level                   set the log4j level for this command
--workers                          turn on worker mode

  SUBCOMMAND is one of:


    Admin Commands:

cacheadmin           configure the HDFS cache
crypto               configure HDFS encryption zones
debug                run a Debug Admin to execute HDFS debug commands
dfsadmin             run a DFS admin client
dfsrouteradmin       manage Router-based federation
ec                   run a HDFS ErasureCoding CLI
fsck                 run a DFS filesystem checking utility
haadmin              run a DFS HA admin client
jmxget               get JMX exported values from NameNode or DataNode.
oev                  apply the offline edits viewer to an edits file
oiv                  apply the offline fsimage viewer to an fsimage
oiv_legacy           apply the offline fsimage viewer to a legacy fsimage
storagepolicies      list/get/set/satisfyStoragePolicy block storage policies

    Client Commands:

classpath            prints the class path needed to get the hadoop jar and the required libraries
dfs                  run a filesystem command on the file system
envvars              display computed Hadoop environment variables
fetchdt              fetch a delegation token from the NameNode
getconf              get config values from configuration
groups               get the groups which users belong to
lsSnapshottableDir   list all snapshottable dirs owned by the current user
snapshotDiff         diff two snapshots of a directory or diff the current directory contents with a snapshot
version              print the version

    Daemon Commands:

balancer             run a cluster balancing utility
datanode             run a DFS datanode
dfsrouter            run the DFS router
diskbalancer         Distributes data evenly among disks on a given node
httpfs               run HttpFS server, the HDFS HTTP Gateway
journalnode          run the DFS journalnode
mover                run a utility to move block replicas across storage types
namenode             run the DFS namenode
nfs3                 run an NFS version 3 gateway
portmap              run a portmap service
secondarynamenode    run the DFS secondary namenode
lsps                  run external storagepolicysatisfier
zkfc                 run the ZK Failover Controller daemon

SUBCOMMAND may print help when invoked w/o parameters or with -h.
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log_backup			    output_enwiki-pages-articles_0_256	output_web-BerkStan_0_1  output_web-BerkStan_0_256  output_web-BerkStan_1_2    README.md	    run.sh    web-BerkStan
log	 output_enwiki-pages-articles_0_16  output_enwiki-pages-articles_1_16	output_web-BerkStan_0_2  output_web-BerkStan_1_16   output_web-BerkStan_1_256  run_hardware_log.sh  tasks.py  web-BerkStan.txt
node0:~/CS744_BigDataSystem/assignment1/part3> mv log log_backup2
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive     log_backup2			       output_enwiki-pages-articles_0_256  output_web-BerkStan_0_1  output_web-BerkStan_0_256  output_web-BerkStan_1_2	  README.md	       run.sh	 web-BerkStan
log_backup  output_enwiki-pages-articles_0_16  output_enwiki-pages-articles_1_16   output_web-BerkStan_0_2  output_web-BerkStan_1_16   output_web-BerkStan_1_256  run_hardware_log.sh  tasks.py  web-BerkStan.txt
node0:~/CS744_BigDataSystem/assignment1/part3> clear; bash run.sh hpark376

========== PART 3: PageRank ==========
>> Username: hpark376
>> Data: 
Usage: ./run.sh [user name] [web-BerkStan or enwiki-pages-articles]
node0:~/CS744_BigDataSystem/assignment1/part3> vim run.sh 
node0:~/CS744_BigDataSystem/assignment1/part3> clear; bash run.sh hpark376 











































































node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> vi log
node0:~/CS744_BigDataSystem/assignment1/part3> vim tasks.py 
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> pwd
/users/hpark376/CS744_BigDataSystem/assignment1/part3
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
node0:~/CS744_BigDataSystem/assignment1/part3> cd /users/hpark376/CS744_BigDataSystem/assignment1/part3/log_py
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> pwd
/users/hpark376/CS744_BigDataSystem/assignment1/part3/log_py
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> ls
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> ls
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> ls
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> ls
node0:~/CS744_BigDataSystem/assignment1/part3/log_py> cd ..
node0:~/CS744_BigDataSystem/assignment1/part3> ks
ks: Command not found.
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls log
cpu.txt  task_1_256_datanode1.stat  task_1_256_datanode2.stat  task_1_256_namenode.stat
node0:~/CS744_BigDataSystem/assignment1/part3> ls 
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls l
log/         log_backup/  log_backup2/ log_py/      log_wiki/    
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_
log_backup/  log_backup2/ log_py/      log_wiki/    
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py/
log_256_1.txt
node0:~/CS744_BigDataSystem/assignment1/part3> ls
archive  log  log_backup  log_backup2  log_py  log_wiki  README.md  run_hardware_log.sh  run.sh  tasks.py  web-BerkStan
node0:~/CS744_BigDataSystem/assignment1/part3> ls log_py
log_256_1.txt
node0:~/CS744_BigDataSystem/assignment1/part3> cd ../../
node0:~/CS744_BigDataSystem> gti stash
gti: Command not found.
node0:~/CS744_BigDataSystem> git stash
git pullSaved working directory and index state WIP on main: eb7a146 logging fixed



^C
node0:~/CS744_BigDataSystem> ls
assignment1  README.md
node0:~/CS744_BigDataSystem> git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p23927984p25427984
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p25427984p26823658
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p26823661p28323661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p28323661p29823661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p29823661p30503448
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p30503454p32003454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p32003454p33503454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p33503454p33952815
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p33952817p35452817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p35452817p36952817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p36952817p38067198
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles26.xml-p38067204p39567204
	modified:   assignment1/part3/run.sh
	modified:   assignment1/part3/run_hardware_log.sh
	modified:   assignment1/part3/tasks.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	assignment1/part2/export.csv

no changes added to commit (use "git add" and/or "git commit -a")
node0:~/CS744_BigDataSystem> vim .gitignore
inode0:~/CS744_BigDataSystem> vim .gitignore
node0:~/CS744_BigDataSystem> git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitignore
	modified:   assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p23927984p25427984
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p25427984p26823658
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p26823661p28323661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p28323661p29823661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p29823661p30503448
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p30503454p32003454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p32003454p33503454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p33503454p33952815
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p33952817p35452817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p35452817p36952817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p36952817p38067198
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles26.xml-p38067204p39567204
	modified:   assignment1/part3/run.sh
	modified:   assignment1/part3/run_hardware_log.sh
	modified:   assignment1/part3/tasks.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	assignment1/part2/export.csv

no changes added to commit (use "git add" and/or "git commit -a")
node0:~/CS744_BigDataSystem> vim .gitignore
node0:~/CS744_BigDataSystem> git stash
Saved working directory and index state WIP on main: eb7a146 logging fixed
node0:~/CS744_BigDataSystem> git add .
git fatal: Unable to write new index file
node0:~/CS744_BigDataSystem> git pull
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 9 (delta 0), reused 9 (delta 0), pack-reused 0
error: unable to create temporary file: No space left on device
fatal: failed to write object
fatal: unpack-objects failed
node0:~/CS744_BigDataSystem> git add .
fatal: Unable to write new index file
node0:~/CS744_BigDataSystem> git stash pop
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles26.xml-p38067204p39567204
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p36952817p38067198
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p35452817p36952817
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p33952817p35452817
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p33503454p33952815
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p32003454p33503454
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p30503454p32003454
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p29823661p30503448
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p28323661p29823661
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p26823661p28323661
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p25427984p26823658
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p23927984p25427984
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitignore
	modified:   assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p23927984p25427984
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p25427984p26823658
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p26823661p28323661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p28323661p29823661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p29823661p30503448
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p30503454p32003454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p32003454p33503454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p33503454p33952815
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p33952817p35452817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p35452817p36952817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p36952817p38067198
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles26.xml-p38067204p39567204
	modified:   assignment1/part3/run.sh
	modified:   assignment1/part3/run_hardware_log.sh
	modified:   assignment1/part3/tasks.py

no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (b40d4421952685cf2f5a8790fbdfbe3e34db924a)
node0:~/CS744_BigDataSystem> git add .
node0:~/CS744_BigDataSystem> git stash pop
CONFLICT (modify/delete): assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980 deleted in Stashed changes and modified in Updated upstream. Version Updated upstream of assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980 left in tree.
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p21222161p22722161
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles20.xml-p20254736p21222156
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles20.xml-p18754736p20254736
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles2.xml-p30304p88444
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles19.xml-p17620548p18754723
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles19.xml-p16120548p17620548
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles18.xml-p15193075p16120541
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles17.xml-p13039268p13693066
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles17.xml-p11539268p13039268
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles16.xml-p9518059p11018059
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles16.xml-p11018059p11539266
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles15.xml-p9244803p9518046
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles15.xml-p7744803p9244803
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles14.xml-p7697599p7744799
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles14.xml-p6197599p7697599
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles13.xml-p5040438p6197593
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles12.xml-p3926864p5040435
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles11.xml-p3046517p3926861
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles10.xml-p2336425p3046511
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles1.xml-p10p30302
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/get
Removing assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/.swp
node0:~/CS744_BigDataSystem> git add .
node0:~/CS744_BigDataSystem> git log
commit eb7a146b023835fabb6422c13cd8618c07d1504c (HEAD -> main)
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 18:21:00 2022 -0400

    logging fixed

commit de53ad5f3d259e55e54efedae256c108fb53de38 (origin/main, origin/HEAD)
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 16:06:42 2022 -0400

    readme added

commit f2b5842f91da36641dac13fd246842971425ef35
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:59:12 2022 -0400

    part2

commit 4bc8272cdf829d0b4cf09fcb3319e2006eabd416
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:06:10 2022 -0400

    task 23 runs

node0:~/CS744_BigDataSystem> :
node0:~/CS744_BigDataSystem> git pull
remote: Enumerating objects: 25, done.
remote: Counting objects: 100% (25/25), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 17 (delta 5), reused 17 (delta 5), pack-reused 0
Unpacking objects: 100% (17/17), done.
From https://github.com/hjoonpark/CS744_BigDataSystem
   de53ad5..864139b  main       -> origin/main
error: Your local changes to the following files would be overwritten by merge:
	.gitignore
	assignment1/part3/README.md
	assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	assignment1/part3/run.sh
	assignment1/part3/run_hardware_log.sh
	assignment1/part3/tasks.py
Please commit your changes or stash them before you merge.
Aborting
node0:~/CS744_BigDataSystem> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 1 and 2 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   .gitignore
	modified:   assignment1/part3/README.md
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/.swp
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/get
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles1.xml-p10p30302
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles10.xml-p2336425p3046511
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles11.xml-p3046517p3926861
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles12.xml-p3926864p5040435
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles13.xml-p5040438p6197593
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles14.xml-p6197599p7697599
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles14.xml-p7697599p7744799
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles15.xml-p7744803p9244803
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles15.xml-p9244803p9518046
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles16.xml-p11018059p11539266
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles16.xml-p9518059p11018059
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles17.xml-p11539268p13039268
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles17.xml-p13039268p13693066
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles18.xml-p15193075p16120541
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles19.xml-p16120548p17620548
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles19.xml-p17620548p18754723
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles2.xml-p30304p88444
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles20.xml-p18754736p20254736
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles20.xml-p20254736p21222156
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p21222161p22722161
	renamed:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p33503454p33952815 -> assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p23927984p25427984
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles22.xml-p25427984p26823658
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p26823661p28323661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p28323661p29823661
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles23.xml-p29823661p30503448
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p30503454p32003454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles24.xml-p32003454p33503454
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p33952817p35452817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p35452817p36952817
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles25.xml-p36952817p38067198
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles26.xml-p38067204p39567204
	modified:   assignment1/part3/run.sh
	modified:   assignment1/part3/run_hardware_log.sh
	modified:   assignment1/part3/tasks.py

node0:~/CS744_BigDataSystem> git add .
node0:~/CS744_BigDataSystem> git commit -m 'sync'
git push
[main f04895e] sync
 Committer: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

^C
node0:~/CS744_BigDataSystem> git log
commit f04895ef149707710726794c85450eb57fd98267 (HEAD -> main)
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Wed Sep 28 06:46:40 2022 -0400

    sync

commit eb7a146b023835fabb6422c13cd8618c07d1504c
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 18:21:00 2022 -0400

    logging fixed

commit de53ad5f3d259e55e54efedae256c108fb53de38
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 16:06:42 2022 -0400

    readme added

commit f2b5842f91da36641dac13fd246842971425ef35
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:59:12 2022 -0400

    part2

node0:~/CS744_BigDataSystem> 
node0:~/CS744_BigDataSystem> git pull
Auto-merging assignment1/part3/tasks.py
Auto-merging assignment1/part3/README.md
CONFLICT (content): Merge conflict in assignment1/part3/README.md
Auto-merging assignment1/README.md
CONFLICT (add/add): Merge conflict in assignment1/README.md
Automatic merge failed; fix conflicts and then commit the result.
node0:~/CS744_BigDataSystem> vim README.md 
node0:~/CS744_BigDataSystem> git stash
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
assignment1/README.md: unmerged (032c9f844e48d8ba210b6bb5bdc6087c07371ffd)
assignment1/README.md: unmerged (35bb0175af17c75258e58809976cfd5e56d40274)
assignment1/part3/README.md: unmerged (9652e9bb10f8d3e3b1be52d6a3dabcd1b3b6c17f)
assignment1/part3/README.md: unmerged (6b65b2d57d1984a4e5579546644410d95059592e)
assignment1/part3/README.md: unmerged (5be57dff88401ccafaabf9c8923ee27a88c7429d)
fatal: git-write-tree: error building trees
Cannot save the current index state
node0:~/CS744_BigDataSystem> git pull
error: Pulling is not possible because you have unmerged files.
hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit.
fatal: Exiting because of an unresolved conflict.
node0:~/CS744_BigDataSystem> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 2 and 2 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Changes to be committed:

	modified:   README.md
	new file:   assignment1/part2/README.md
	modified:   assignment1/part2/part2.py
	modified:   assignment1/part3/tasks.py

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both added:      assignment1/README.md
	both modified:   assignment1/part3/README.md

node0:~/CS744_BigDataSystem> git rm -r --cached
usage: git rm [<options>] [--] <file>...

    -n, --dry-run         dry run
    -q, --quiet           do not list removed files
    --cached              only remove from the index
    -f, --force           override the up-to-date check
    -r                    allow recursive removal
    --ignore-unmatch      exit with a zero status even if nothing matched

node0:~/CS744_BigDataSystem> git rm -r --cached .
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
rm '.gitignore'
rm 'README.md'
rm 'assignment1/README.md'
rm 'assignment1/README.md'
rm 'assignment1/hosts'
rm 'assignment1/part2/README.md'
rm 'assignment1/part2/part2.py'
rm 'assignment1/part2/run.sh'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/archive/task1.py'
rm 'assignment1/part3/archive/task2.py'
rm 'assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980'
rm 'assignment1/part3/run.sh'
rm 'assignment1/part3/run_hardware_log.sh'
rm 'assignment1/part3/tasks.py'
rm 'assignment1/reconfig.sh'
node0:~/CS744_BigDataSystem> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 2 and 2 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)

All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:

	deleted:    .gitignore
	deleted:    README.md
	deleted:    assignment1/README.md
	deleted:    assignment1/hosts
	deleted:    assignment1/part2/part2.py
	deleted:    assignment1/part2/run.sh
	deleted:    assignment1/part3/README.md
	deleted:    assignment1/part3/archive/task1.py
	deleted:    assignment1/part3/archive/task2.py
	deleted:    assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980
	deleted:    assignment1/part3/run.sh
	deleted:    assignment1/part3/run_hardware_log.sh
	deleted:    assignment1/part3/tasks.py
	deleted:    assignment1/reconfig.sh

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore
	README.md
	assignment1/

node0:~/CS744_BigDataSystem> git stash
git Saved working directory and index state WIP on main: f04895e sync
node0:~/CS744_BigDataSystem> git pull
error: The following untracked working tree files would be overwritten by merge:
	assignment1/part2/README.md
Please move or remove them before you merge.
Aborting
node0:~/CS744_BigDataSystem> rm assignment1/part2/README.md 
node0:~/CS744_BigDataSystem> git pull
Auto-merging assignment1/part3/tasks.py
Auto-merging assignment1/part3/README.md
CONFLICT (content): Merge conflict in assignment1/part3/README.md
Auto-merging assignment1/README.md
CONFLICT (add/add): Merge conflict in assignment1/README.md
Automatic merge failed; fix conflicts and then commit the result.
node0:~/CS744_BigDataSystem> git vim assignment1/p
part2/ part3/ 
node0:~/CS744_BigDataSystem> git vim assignment1/part3/tasks.py 
git: 'vim' is not a git command. See 'git --help'.

The most similar command is
	var
node0:~/CS744_BigDataSystem> vim assignment1/part3/tasks.py
node0:~/CS744_BigDataSystem> git stash pop
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
unable to refresh index
node0:~/CS744_BigDataSystem> git log
commit f04895ef149707710726794c85450eb57fd98267 (HEAD -> main)
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Wed Sep 28 06:46:40 2022 -0400

    sync

commit eb7a146b023835fabb6422c13cd8618c07d1504c
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 18:21:00 2022 -0400

    logging fixed

commit de53ad5f3d259e55e54efedae256c108fb53de38
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 16:06:42 2022 -0400

    readme added

commit f2b5842f91da36641dac13fd246842971425ef35
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:59:12 2022 -0400

    part2

node0:~/CS744_BigDataSystem> :
node0:~/CS744_BigDataSystem> git push
Username for 'https://github.com': hjoonpark
Password for 'https://hjoonpark@github.com': 
To https://github.com/hjoonpark/CS744_BigDataSystem.git
 ! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to 'https://github.com/hjoonpark/CS744_BigDataSystem.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
node0:~/CS744_BigDataSystem> git pull
error: Pulling is not possible because you have unmerged files.
hint: Fix them up in the work tree, and then use 'git add/rm <file>'
hint: as appropriate to mark resolution and make a commit.
fatal: Exiting because of an unresolved conflict.
node0:~/CS744_BigDataSystem> git rm -r cached .
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
fatal: pathspec 'cached' did not match any files
node0:~/CS744_BigDataSystem> git rm -r --cached .
assignment1/README.md: needs merge
assignment1/part3/README.md: needs merge
rm '.gitignore'
rm 'README.md'
rm 'assignment1/README.md'
rm 'assignment1/README.md'
rm 'assignment1/hosts'
rm 'assignment1/part2/README.md'
rm 'assignment1/part2/part2.py'
rm 'assignment1/part2/run.sh'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/README.md'
rm 'assignment1/part3/archive/task1.py'
rm 'assignment1/part3/archive/task2.py'
rm 'assignment1/part3/part3/enwiki-pages-articles/enwiki-pages-articles/link-enwiki-20180601-pages-articles21.xml-p22722161p23927980'
rm 'assignment1/part3/run.sh'
rm 'assignment1/part3/run_hardware_log.sh'
rm 'assignment1/part3/tasks.py'
rm 'assignment1/reconfig.sh'
node0:~/CS744_BigDataSystem> git log
commit f04895ef149707710726794c85450eb57fd98267 (HEAD -> main)
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Wed Sep 28 06:46:40 2022 -0400

    sync

commit eb7a146b023835fabb6422c13cd8618c07d1504c
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 18:21:00 2022 -0400

    logging fixed

commit de53ad5f3d259e55e54efedae256c108fb53de38
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 16:06:42 2022 -0400

    readme added

commit f2b5842f91da36641dac13fd246842971425ef35
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:59:12 2022 -0400

    part2

node0:~/CS744_BigDataSystem> 
node0:~/CS744_BigDataSystem> git pull
error: You have not concluded your merge (MERGE_HEAD exists).
hint: Please, commit your changes before merging.
fatal: Exiting because of unfinished merge.
node0:~/CS744_BigDataSystem> git commit -m 'sync2'
[main 014b23e] sync2
 Committer: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Your name and email address were configured automatically based
on your username and hostname. Please check that they are accurate.
You can suppress this message by setting them explicitly. Run the
following command and follow the instructions in your editor to edit
your configuration file:

    git config --global --edit

After doing this, you may fix the identity used for this commit with:

    git commit --amend --reset-author

node0:~/CS744_BigDataSystem> git push
Username for 'https://github.com': hjoonpark
Password for 'https://hjoonpark@github.com': 
Counting objects: 61, done.
Delta compression using up to 5 threads.
Compressing objects: 100% (55/55), done.
error: RPC failed; curl 55 The requested URL returned error: 401
fatal: The remote end hung up unexpectedly
Writing objects: 100% (61/61), 1.35 GiB | 3.70 MiB/s, done.
Total 61 (delta 11), reused 0 (delta 0)
fatal: The remote end hung up unexpectedly
Everything up-to-date
node0:~/CS744_BigDataSystem> git log
commit 014b23e1b3628cc6a9420b9548e8764be07747c4 (HEAD -> main)
Merge: f04895e 864139b
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Wed Sep 28 06:50:20 2022 -0400

    sync2

commit f04895ef149707710726794c85450eb57fd98267
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Wed Sep 28 06:46:40 2022 -0400

    sync

commit 864139b2ef208f52f1513874b9aa3b062db389d7 (origin/main, origin/HEAD)
Author: Joon Park <hjoonpark.us@gmail.com>
Date:   Wed Sep 28 05:44:01 2022 -0500

    readme edit

commit 13c2461352247c06884e115aac276e681af5dae3
Author: Joon Park <hjoonpark.us@gmail.com>
Date:   Wed Sep 28 05:38:12 2022 -0500

    read me added

commit eb7a146b023835fabb6422c13cd8618c07d1504c
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 18:21:00 2022 -0400

    logging fixed

commit de53ad5f3d259e55e54efedae256c108fb53de38
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 16:06:42 2022 -0400

    readme added

commit f2b5842f91da36641dac13fd246842971425ef35
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:59:12 2022 -0400

    part2

commit 4bc8272cdf829d0b4cf09fcb3319e2006eabd416
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 12:06:10 2022 -0400

    task 23 runs

commit 415c11d3f35384274ffcad87a173816cdbe64ac9
Author: hpark376 <hpark376@node0.asgn1-group18.uwmadison744-f22-pg0.clemson.cloudlab.us>
Date:   Tue Sep 27 02:16:35 2022 -0400

    part3 with logging
node0:~/CS744_BigDataSystem> ;
node0:~/CS744_BigDataSystem> git push
Username for 'https://github.com': hjoonpark
Password for 'https://hjoonpark@github.com': 
Counting objects: 61, done.
Delta compression using up to 5 threads.
^Cmpressing objects:  30% (17/55)   
node0:~/CS744_BigDataSystem> 
node0:~/CS744_BigDataSystem> pwd
/users/hpark376/CS744_BigDataSystem
node0:~/CS744_BigDataSystem> cd assignment1/
node0:~/CS744_BigDataSystem/assignment1> cd pa
part2/ part3/ 
node0:~/CS744_BigDataSystem/assignment1> cd part3
node0:~/CS744_BigDataSystem/assignment1/part3> vim run.sh 

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