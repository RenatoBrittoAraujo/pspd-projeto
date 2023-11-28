echo "-----> gerando palavras"
cd word_generator ;\
pip install -r requirements.txt ;\
python3 wordgenerator.py ;\

echo "-----> reiniciando servicos"
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/stop-dfs.sh'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/stop-yarn.sh'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/start-dfs.sh'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/sbin/start-yarn.sh'

echo "-----> ajustando hdfs para receber resposta (removendo arquivos antigos)"
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfsadmin -safemode leave' ;\
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -mkdir /input' ;\
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -rm /input/input.txt' ;\
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -rm /output/*' ;\
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -rm /user/root/output/*' ;\
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -rmdir /user/root/output' ;\

# sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -rm /input/input.txt' ;\

echo "-----> copiando input pra hdfs"
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -put ./word_generator/large_lorem.txt /input/input.txt' ;\

# rm word_generator/large_lorem.txt ;\

echo "-----> compilando programa de wordcount"
sudo docker-compose exec hadoop-master /bin/bash -c 'cd WordCount; javac -classpath ${HADOOP_PREFIX}/share/hadoop/common/hadoop-common-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/common/lib/* Wordcount.java; jar cvf wordcount.jar *.class' ;\

echo "-----> rodando word count"
sudo docker-compose exec hadoop-master /bin/bash -c 'cd WordCount && $HADOOP_PREFIX/bin/hadoop jar wordcount.jar Wordcount /input/input.txt output'

echo "-----> copia output do hdfs dentro do container para o container"
sudo docker-compose exec hadoop-master /bin/bash -c 'rm part-r-00000'
sudo docker-compose exec hadoop-master /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -copyToLocal /user/root/output/part-r-00000 .'

echo "-----> copia output do container docker para sistema local"
sudo docker cp hadoop-master:/part-r-00000 .
