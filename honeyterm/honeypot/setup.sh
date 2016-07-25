#!/bin/bash
syslog_ip=172.17.0.240
account=guest
password="\$6\$Y.8OH9VC\$/nIduftdGeWemAm87gWxplL6hga04ibI9DwHxkxWW7dNUApr6BUEuXqHF9DErMIbID2C5A1oY4i2eWZf1U.A6/"

#backup
cp /etc/pam.d/sshd /etc/pam.d/sshd.bak
cp /etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf.bak

# account / password
useradd -m -p "$password" -s /bin/bash $account
cat >> /home/$account/.bashrc << _EOF_

if [ -z \$already_showterm ]; then
export already_showterm=true
/usr/local/rvm/wrappers/ruby-2.2.2/showterm
exit
fi
_EOF_

#install PAM
mark_line=`grep -n "include common-auth" /etc/pam.d/sshd | awk -F: '{print $1}'`
((mark_line++))
sed -i 's/@include common-auth/#@include common-auth/g' /etc/pam.d/sshd
line="iauth       requisite     pam_python.so pwreveal.py"
line=$mark_line$line
sed -i "$line" /etc/pam.d/sshd
cp /root/honeypot/pwreveal.py /lib/security

apt-get -y install libpam-python

#echo "honeypot                        @$syslog_ip" > /etc/rsyslog.d/50-default.conf


