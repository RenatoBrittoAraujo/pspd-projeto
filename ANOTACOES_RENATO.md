containers docker rodando hadoop 2.7.1

172.24.0.2 -slave 1
172.24.0.3 -slave 2
172.24.0.4 -master

ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa

ssh-copy-id -i .ssh/id_rsa.pub hduser@{master and workers}


## Atividade 1 - Montar um cluster Hadoop básico

**Tarefa:** fazer um cluster com dois mestres eum escravo.

**Metodologia:** vou levantar multiplos containers docker. daí vou configurar os ips de cada um pra se comunicar um com o outro em cluster.





## Atividade 2 - Teste do framework Hadoop

**Tarefa:** fazer 5 alterações no cluster, afetar o escalonador de processos Yarn, sistema de
arquivos HDFS, funcionamento geral aplicações

**Metodologia:** alterar arquivos de configuração do Hadoop

## Atividade 3 - Teste do MapReduce no Hadoop

**Tarefa:** fazer wordcount com mapreduce, monitorar map, shuffle/sort e reduce. perceber o funcionamento em termos de uso de recursos.

**Metodologia:** escreve o codigo java pra fazer isso, faz um `.jar` do codigo e roda ele no cluster.

## Atividade 4 - Teste de tolerância a faltas e escalabilidade da aplicação

**Tarefa:** 

**Metodologia:** 

