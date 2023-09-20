Containers docker rodando hadoop 2.7.1

## Atividade 1 - Montar um cluster Hadoop básico

**Tarefa:** fazer um cluster com dois mestres eum escravo.

**Metodologia:** vou levantar multiplos containers docker. daí vou configurar os ips de cada um pra se comunicar um com o outro em cluster.

- 3 containers (1 master, 2 slave) docker com hadoop 2.7 foram levantados
- no container master, colocamos o ip dos slaves
- no container master, criamos um chave ssh
- nos containers slaves, colocamos a chave public ssh do master
- no container master, formatamos o hdfs
- no container master, reiniciamos o hdfs
- fim :)
- interface web com 3 nodes ativos pode ser encontrada em http://0.0.0.0:8088/cluster/nodes

## Atividade 2 - Teste do framework Hadoop

**Tarefa:** fazer 5 alterações no cluster, afetar o escalonador de processos Yarn, sistema de
arquivos HDFS, funcionamento geral aplicações

**Metodologia:** alterar arquivos de configuração do Hadoop

**primeira alteração:** Aumenta o `dfs.replication` de `1` para `2`.

1. Fiz a alteração no `hdfs-site.xml`
2. Levantei o container
3. Entrei no container hadoop-slave-1 com `sudo docker-compose exec hadoop-slave-1 bash`
4. Criei um arquivo com 1.1MB (ou 1056 kilobytes) `head -c 1100000 </dev/urandom >aa`
5. Adicionei o arquivo no sistema pelo comando `$HADOOP_PREFIX/bin/hdfs dfs -put aa`
6. Ao todo, 2.12MB de memória começaram a ser utilizados no cluster (ou `1.06 * 2`)

Dai aumenta o `dfs.replication` de `2` para `3`.

Seguindo os passos anteriores, esperamos agora `1.06 * 3` MB. 

1. Derrubei o sistema
2. Aumentei a replication para 3 no `hdfs-site.xml` 
3. Levantei o sistema
4. Ao todo, 3.18MB começaram a ser utilizados, com 1.06MB em cada cluster.

**terceira alteração:**

**quarta alteração:**

**quinta alteração:**


## Atividade 3 - Teste do MapReduce no Hadoop

**Tarefa:** fazer wordcount com mapreduce, monitorar map, shuffle/sort e reduce. perceber o funcionamento em termos de uso de recursos.

**Metodologia:** escreve o codigo java pra fazer isso, faz um `.jar` do codigo e roda ele no cluster.

1. Copia com `sudo docker cp sources/WordCount/ hadoop-slave-1:/WordCount`

2. Entra no container hadoop-slave-1 com `sudo docker-compose exec hadoop-slave-1 bash`

3. Entra na pasta `/WordCount` com `cd /WordCount`

4. Cria pasta de input no HDFS
`$HADOOP_PREFIX/bin/hdfs dfs -mkdir /input`

1. Insere o arquivo de input em `/input/input.txt` no HDFS.
`$HADOOP_PREFIX/bin/hdfs dfs -put input.txt /input`

1. Compila java
`javac -classpath ${HADOOP_PREFIX}/share/hadoop/common/hadoop-common-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/common/lib/* Wordcount.java &>f`

1. Criar .jar do java compilado
`jar cvf wordcount.jar *.class`

1. Roda o .jar
`$HADOOP_PREFIX/bin/hadoop jar wordcount.jar Wordcount /input/input.txt output`

## Atividade 4 - Teste de tolerância a faltas e escalabilidade da aplicação

**Tarefa:** Testar tolerância de erros do sistema com grande input

**Metodologia:** Será criado um input grande e testado o sistema quando um ou dois nodes slaves e o master caíram.

1. Crie um arquivo de texto com 15MB `cd word_generator; pip install -r requirements.txt; python wordgenerator.py`
2. Entre no container `sudo docker-compose exec hadoop-slave-1 bash`
3. Crie a pasta `input` no hdfs com `$HADOOP_PREFIX/bin/hdfs dfs -mkdir \input`
4. Adiciona o arquivo de texto `/input/input.txt` no hdfs com `$HADOOP_PREFIX/bin/hdfs dfs -put ./wordgenerator/large_lorem.txt /input/input.txt`
5. Entre na pasta `WordCount` com `cd WordCount`
6. Compile o código `javac -classpath ${HADOOP_PREFIX}/share/hadoop/common/hadoop-common-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.7.0.jar:${HADOOP_PREFIX}/share/hadoop/common/lib/* Wordcount.java`
7. Criar .jar do java compilado `jar cvf wordcount.jar *.class`
8. Roda o .jar `$HADOOP_PREFIX/bin/hadoop jar wordcount.jar Wordcount /input/input.txt output`

#### Condição adversa 1: Um nó slave caiu

1. Roda o código
2. Derruba o container `sudo docker-compose down hadoop-slave-1`
3. Acompanhar logs no `http://0.0.0.0:8088`

#### Condição adversa 2: Dois nó slave cairam

1. Restaurar todos os containers
2. Roda o código
3. Derruba o container `sudo docker-compose down hadoop-slave-1`
4. Derruba o container `sudo docker-compose down hadoop-slave-2`
5. Acompanhar logs no `http://0.0.0.0:8088`

#### Condição adversa 3: Nó master caiu


1. Restaurar todos os containers
2. Roda o código
4. Derruba o container `sudo docker-compose down hadoop-master`
5. Acompanhar logs no `http://0.0.0.0:8088` (que é a porta pra web interface do slave-1)

