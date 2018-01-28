# honeyterm
Docker based high interaction honeypot


INSTALL
=======

# Environment Setup


## 1. Change your ssh port from 22 to 2222(or other), and restart sshd

   vi /etc/ssh/sshd_config
  
   Port 2222
  
   restart sshd

## 2. Install xinetd

   apt-get install xinetd

## 3. Install socat

   apt-get install socat

## 4. Install scripts

   cp scripts/honeypot /usr/bin/honeypot

   cp xinetd/honeypot /etc/xinetd.d/honeypot

## 5. Add honeypot port 22 to services

   vi /etc/services
   
   honeypot        22/tcp

## 6. Restart xinetd
   restart xinetd


# Make Honeypot Docker Image

The original honeyterm uses showterm, but I replace it with asciinema, you just need to choose one of them to make.

## Asciinema

```
cd honeyterm_asciinema
make
make build
```

## Showterm
 
```
cd honeyterm
make
make build
```

# Usage

`$ ssh guest@[IP/Domain Name]` default password is "honeypot"

Type some command there, and logout.

You can now use `$ sudo docker exec -it {Your_Container} bash` to login without commands record

All records are saved in /tmp

If you use honeyterm_asciinema, you can use "getAsciinema.sh" to copy asciinema's json file from all containers.

You can put honeypot.clean to crontab, which can clean container and backup log in /var/log/honeypot

