cd word_generator
pip install -r requirements.txt
python wordgenerator.py

sudo docker-compose exec hadoop-slave-1 /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -mkdir /input'

sudo docker-compose exec hadoop-slave-1 /bin/bash -c '$HADOOP_PREFIX/bin/hdfs dfs -put ./word_generator/large_lorem.txt /input/input.txt'

rm word_generator/large_lorem.txt

sudo docker-compose exec hadoop-slave-1 /bin/bash -c 'cd WordCount; javac -classpath ${HADOOP_PREFIX}/share/hadoop/common/hadoop-common-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/common/lib/* Wordcount.java; jar cvf wordcount.jar *.class'

sudo docker-compose exec hadoop-slave-1 /bin/bash -c 'cd WordCount && $HADOOP_PREFIX/bin/hadoop jar wordcount.jar Wordcount /input/input.txt output'

