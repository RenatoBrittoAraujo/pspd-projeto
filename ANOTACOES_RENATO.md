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

**primeira alteração:**

**segunda alteração:**

**terceira alteração:**

**quarta alteração:**

**quinta alteração:**


## Atividade 3 - Teste do MapReduce no Hadoop

**Tarefa:** fazer wordcount com mapreduce, monitorar map, shuffle/sort e reduce. perceber o funcionamento em termos de uso de recursos.

**Metodologia:** escreve o codigo java pra fazer isso, faz um `.jar` do codigo e roda ele no cluster.



## Atividade 4 - Teste de tolerância a faltas e escalabilidade da aplicação

**Tarefa:** 

**Metodologia:** 

