FROM ubuntu:14.04



ADD showterm.tar /root
ADD honeypot.tar /root

WORKDIR /root/showterm

# Install packages
RUN apt-get update \
  && apt-get -y install curl \
  && apt-get -y install wget

# Install openssh-server
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd

# Install gcc and make
RUN apt-get -y install gcc-4.8 \
  && apt-get -y install gcc \
  && apt-get -y install make
# Install Ruby 2.2.2
RUN command curl -sSL https://rvm.io/mpapis.asc | gpg --import - \
  && curl -L https://get.rvm.io | bash -s stable --ruby 

RUN /bin/bash -c "cd /root/showterm && source /usr/local/rvm/scripts/rvm \
  && rvm install ruby-2.2.2 \
  && rvm --default use ruby-2.2.2 \
  && gem install showterm"

#RUN sed -i 's/start on (filesystem and static-network-up) or failsafe-boot/start on filesystem/' /etc/init/rc-sysinit.conf
#RUN sed -i 's/start on runlevel \[2345\]/start on filesystem/g' /etc/init/ssh.conf

RUN cd /etc/rc3.d && ln -s ../init.d/ssh S99ssh
RUN cd /etc/rc3.d && ln -s ../init.d/rsyslog S99rsyslogd

#RUN cd /root && rm -rf showterm
#RUN apt-get -y remove make \
#  && apt-get -y remove gcc \
#  && apt-get -y remove gcc-4.8

RUN /root/honeypot/setup.sh
RUN cp /root/honeypot/pwreveal.py /lib/security
RUN cp /root/showterm/bin/showterm /usr/local/rvm/gems/ruby-2.2.2/gems/showterm-0.5.0/bin/
EXPOSE 22/tcp
#ENTRYPOINT ["/usr/local/bin/showterm","/bin/bash"]
ENTRYPOINT ["/sbin/init"]

