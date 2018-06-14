

FROM ubuntu:16.04
MAINTAINER Florian Pereme <florian.pereme@altran.com>




# Install Utilities
RUN apt-get update -y
RUN apt-get install -y curl
RUN apt-get install -y git
RUN apt-get install -y ssh
RUN apt-get install -y sudo
RUN apt-get install -y sudo
RUN apt-get install -y net-tools
RUN apt-get install -y screen
RUN apt-get install -y openssh-server
RUN apt-get install -y openssh-client
RUN apt-get install -y passwd
RUN apt-get install -y wget
RUN apt-get install -y libglib2.0-dev
Run apt-get install -y tzdata


# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
RUN sudo apt-get install -y nodejs

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
#RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list


RUN apt-get update && apt-get install -y --allow-unauthenticated mongodb-org mongodb-org-server mongodb-org-shell mongodb-org-mongos mongodb-org-tools
RUN apt-get install -y --force-yes mongodb-org=3.6.1 mongodb-org-server=3.6.1 mongodb-org-shell=3.6.1 mongodb-org-mongos=3.6.1 mongodb-org-tools=3.6.1
#RUN mkdir -p /data/db
#RUN chown -R mongodb:mongodb /data/db

#Configure Mongo file system
RUN mkdir -p /data/db
RUN chown -R mongodb:mongodb /data


#Install openssh server
RUN mkdir -p /var/run/sshd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'root:medica' | chpasswd

EXPOSE 27017 80 8080 8082 22

CMD mongod
CMD /usr/sbin/sshd -D

