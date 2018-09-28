FROM ubuntu:16.04
MAINTAINER Gary Leong <gwleong@gmail.com>

############################################################
#####Basic Pkgs - Public
############################################################
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

RUN echo "Installing Basic Pkgs" && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    apt-get update && \
    apt-get install -y pwgen wget curl libssl-dev rng-tools haveged \
                       openssh-server supervisor

RUN echo "Installing Docker Pkgs" && \
    apt-get -y install docker.io 

# Install docker-compose
RUN sh -c "curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose" && \
    chmod +x /usr/local/bin/docker-compose
RUN sh -c "curl -L https://raw.githubusercontent.com/docker/compose/1.8.1/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose" 

RUN mkdir -p /var/run/sshd /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
CMD ["/usr/bin/supervisord"]
