FROM ubuntu:14.04

ADD asciinema.tar /root
ADD honeypot.tar /root

WORKDIR /root/asciinema

# Install packages
RUN apt-get update \
  && apt-get -y install curl \
  && apt-get -y install wget

# Install openssh-server
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd

# Install python-setuptools
RUN apt-get -y install python3-setuptools

# Generates localisation files for asciinema
RUN locale-gen en_US.UTF-8
RUN echo "export LC_ALL=en_US.UTF-8" >> /root/bashrc

#RUN sed -i 's/start on (filesystem and static-network-up) or failsafe-boot/start on filesystem/' /etc/init/rc-sysinit.conf
#RUN sed -i 's/start on runlevel \[2345\]/start on filesystem/g' /etc/init/ssh.conf

RUN cd /etc/rc3.d && ln -s ../init.d/ssh S99ssh
RUN cd /etc/rc3.d && ln -s ../init.d/rsyslog S99rsyslogd

# Install asciinema via modified package
Run python3 /root/asciinema/setup.py install

RUN /root/honeypot/setup.sh
RUN cp /root/honeypot/pwreveal.py /lib/security
EXPOSE 22/tcp
#ENTRYPOINT ["/usr/local/bin/showterm","/bin/bash"]
ENTRYPOINT ["/sbin/init"]

