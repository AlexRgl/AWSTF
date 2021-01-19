#!/bin/bash -x
UTILIZADOR="maria"
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
## Create an user
sudo adduser --disabled-password --gecos "" $UTILIZADOR
## Change passwd
sudo echo "$UTILIZADOR:Passw0rd"|chpasswd
## isso
sudo echo xfce4-session > /home/$UTILIZADOR/.xsession
