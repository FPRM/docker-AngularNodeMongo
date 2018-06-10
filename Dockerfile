FROM ubuntu:xenial
MAINTAINER Florian Pereme <florian.pereme@altran.com>

# Update sources
RUN apt-get update -y

# install http


# install MongoDB

RUN mkdir -p /data/db
RUN apt-get install -y mongodb-org
RUN apt-get install -y mongodb-org-server
RUN apt-get install -y mongodb-org-shell
RUN apt-get install -y mongodb-org-mongos
    #=3.6.1 \
    #=3.6.1 \
    #=3.6.1 \
    #mongodb-org-tools=3.6.1 \
    #sudo \
    #curl \
    #net-tools \
    #git \
    #openssh-server \
    #openssh-client 
    
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
RUN apt-get install -y nodejs


# install sshd

RUN mkdir -p /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'root:medica' | chpasswd

# Put your own public key at id_rsa.pub for key-based login.
#RUN mkdir -p /root/.ssh && touch /root/.ssh/known_hosts && chmod 700 /root/.ssh
#ADD known_hosts /root/.ssh/known_hosts

#Divers
#ADD script.sh /root/
#ADD key_rsa /root/
#ADD version.txt /root/
#ADD vhost_backend.conf /etc/apache2/sites-available/
#ADD .bashrc /root/
EXPOSE 22 
EXPOSE 80 
EXPOSE 8080-8090 
EXPOSE 3306

#pour démarer les services et concerver le containeur ouvert
CMD service mongodb start && /usr/sbin/sshd -D
