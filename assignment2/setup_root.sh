# generate ssh
cd
ssh-keygen -t rsa 

cat ~/.ssh/id_rsa.pub

# send data to workers to test
parallel-ssh -i -h hosts -O StrictHostKeyChecking=no pwd


