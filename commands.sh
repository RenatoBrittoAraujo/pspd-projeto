# set hosts
sudo docker-compose exec hadoop-master /bin/bash -c 'echo "172.20.0.2 hadoop-master" >> /etc/hosts'
sudo docker-compose exec hadoop-master /bin/bash -c 'echo "172.20.0.3 hadoop-slave-1" >> /etc/hosts'
sudo docker-compose exec hadoop-master /bin/bash -c 'echo "172.20.0.4 hadoop-slave-2" >> /etc/hosts'

# create ssh key
sudo docker-compose exec hadoop-master /bin/bash -c 'ssh-keygen -b 4096 -rsa -N ""'

# copy ssh pub key (other containers share this folder)
sudo docker cp hadoop-master:/root/.ssh/id_rsa.pub master.pub
sudo docker cp master.pub hadoop-slave-1:/root/.ssh/authorized_keys
sudo docker cp master.pub hadoop-slave-2:/root/.ssh/authorized_keys

sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs namenode -format'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/stop-dfs.sh'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/start-dfs.sh'
