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

Inicialmente vou tentar compilar e rodar o wordcount na pasta `sources/`.
Vou levar o código pro container, compilar e rodar o comando do mapreduce

1. Copiei com `sudo docker cp sources/WordCount/ hadoop-slave-1:/WordCount`
2. Entrei no container hadoop-slave-1 com `sudo docker-compose exec hadoop-slave-1 bash`
3. ...

Instruções que achei na net para compilar:
$ hdfs dfs -mkdir /input
$ hdfs dfs -put ./input/* /input
$ cd src/main/java
$ hadoop com.sun.tools.javac.Main *.java
$ jar cf recommender.jar *.class
$ hadoop jar recommender.jar Driver /input /output/userRating /output/cooccurrenceGenerator /output/cooccurrenceNormal /output/userAverageRating /output/cellMultiplication /output/cellSum

Vou tentar utilizar o maven, por causa do arquivo `pom.xml` que fica no código do WordCount

pra isso vamos intalar com `sudo yum install maven java-1.8.0-openjdk`


```
cd src/main/java
hadoop com.sun.tools.javac.Main *.java
```



## Atividade 4 - Teste de tolerância a faltas e escalabilidade da aplicação

**Tarefa:** 

**Metodologia:** 

