
#!/bin/bash -x
## Update System
sudo apt update
sudo apt -y upgrade
## Change Root password
sudo sh -c 'echo root:Passw0rd | chpasswd'
## Change Hostname
sudo hostnamectl set-hostname Client
## Install GUI
sudo apt install -y xfce4 xfce4-goodies
## Install Utilitaries
sudo apt install -y xrdp chromium-browser filezilla
## Add User
sudo adduser xrdp ssl-cert
## isso
echo xfce4-session > ~/.xsession