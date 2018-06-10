FROM ubuntu:16.04
MAINTAINER Florian Pereme <florian.pereme@altran.com>

# Update sources
RUN apt-get update -y

# install http


# install MongoDB
RUN mkdir -p /data/db
RUN apt-get install -y mongodb mongodb-server mongodb-clients

# install php
RUN apt-get install -y php7.0 php7.0-mysql libapache2-mod-php7.0 

#Install curl
RUN apt-get install -y curl

#install sudo
RUN apt-get install -y sudo

#install net-tools (netstat/ifconfig etc)
RUN apt-get install -y net-tools


# install nodejs 8.9.4 (dernière stable en 8.x)

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
RUN apt-get install -y nodejs

# install git
RUN apt-get install -y git

# install sshd
RUN apt-get install -y openssh-server openssh-client passwd
RUN mkdir -p /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

# Put your own public key at id_rsa.pub for key-based login.
RUN mkdir -p /root/.ssh && touch /root/.ssh/known_hosts && chmod 700 /root/.ssh
ADD known_hosts /root/.ssh/known_hosts

#Divers
ADD script.sh /root/
ADD key_rsa /root/
ADD version.txt /root/
ADD vhost_backend.conf /etc/apache2/sites-available/
ADD .bashrc /root/
EXPOSE 22 80 8080 8082 3306

#pour démarer les services et concerver le containeur ouvert
CMD service mongodb start && /usr/sbin/sshd -D