FROM sequenceiq/hadoop-docker:2.7.0


# add the hosts
RUN echo "172.20.0.2    hadoop-master" >> /etc/hosts
RUN echo "172.20.0.3    hadoop-slave-1" >> /etc/hosts
RUN echo "172.20.0.4    hadoop-slave-2" >> /etc/hosts

# create ssh key (or get it)
RUN ssh-keygen -b 4096 -rsa -N ''

# copy ssh pub key (other containers share this folder)
RUN cat ~/.ssh/id_rsa.pub >> ~/sshkey/master.pub

