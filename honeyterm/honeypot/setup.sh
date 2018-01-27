#!/bin/bash
syslog_ip=172.17.0.240
account=guest
password="honeypot"

# backup
cp /etc/pam.d/sshd /etc/pam.d/sshd.bak
cp /etc/rsyslog.d/50-default.conf /etc/rsyslog.d/50-default.conf.bak

# account / password
useradd -m  $account -s /bin/bash
echo "$account:$password"|chpasswd

# run showterm right after login from bashrc
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

apt-get -y install libpam-python

#echo "honeypot                        @$syslog_ip" > /etc/rsyslog.d/50-default.conf
