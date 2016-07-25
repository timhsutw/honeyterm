# honeyterm
Docker based high interaction honeypot


INSTALL
=======

# 1. Change your ssh port from 22 to 2222(or other), and restart sshd

   vi /etc/ssh/sshd_config
  
   Port 2222
  
   restart sshd

# 2. Install xinetd

   apt-get install xinetd

# 3. Install socat

   apt-get install socat

# 4. Install scripts

   cp scripts/honeypot /usr/bin/honeypot

   cp xinetd/honeypot /etc/xinetd.d/honeypot

# 5. Add honeypot port 22 to services

   vi /etc/services
   
   honeypot        22/tcp

# 6. Restart xinetd
   restart xinetd

# 7. Make honeypot docker image
 
   cd honeyterm
 
   make
 
   make build


