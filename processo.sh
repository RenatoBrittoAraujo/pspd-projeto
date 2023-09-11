# 1. baixa a imagem
sudo docker pull sequenceiq/hadoop-docker:2.7.0

# 2. roda a imagem
docker run -it sequenceiq/hadoop-docker:2.7.0 /etc/bootstrap.sh -bash
/

# 3. entra no app
# http://172.17.0.2:50070/dfshealth.html#tab-overview

# a essa altura, do hadoop ta rodando na sua maquina :D

# 4. entra na pasta do hadoop no OS
cd $HADOOP_PREFIX

# 5. roda o código ´hello world'
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.0.jar grep input output 'dfs[a-z.]+'



