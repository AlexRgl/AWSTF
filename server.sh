#!/bin/bash -x
## Update System
sudo apt update
sudo apt -y upgrade
## Change Root password
sudo sh -c 'echo root:Passw0rd | chpasswd'
## Change Hostname
sudo hostnamectl set-hostname Server
## Install utilitaries
sudo apt -y install debconf-utils
## Install apache 2
sudo apt -y install apache2
## Enable SSl and site
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
## Restart and Enable the service
sudo systemctl restart apache2
sudo systemctl enable apache2
## Configure to port 8080 and 8443
sudo sed -i 's|80|8080|g' /etc/apache2/ports.conf
sudo sed -i 's|443|8443|g' /etc/apache2/ports.conf
sudo sed -i 's|443|8443|g' /etc/apache2/sites-available/default-ssl.conf
## Restart Again
sudo systemctl restart apache2
## Install ssl-certs
sudo apt -y install ssl-cert
## Install EasyRSA
cd /etc/
git clone https://github.com/OpenVPN/easy-rsa.git
cd /etc/easy-rsa/easyrsa3
## Start EasyRSA
./easyrsa init-pki
## Build-ca
./easyrsa \
  --batch \
  --dn-mode=org \
  --req-c=PT \
  --req-st=Azores \
  --req-city="Ponta Delgada" \
  --req-org="Entidade Certificadora Nacional" \
  --req-email=webmaster@entcert.pt \
  --req-ou="Departamento de Certificados" \
  --req-cn=*.amazonaws.com \
  build-ca nopass
## Build-Server-Full
./easyrsa \
  --batch \
  --dn-mode=org \
  --req-c=PT \
  --req-st=Azores \
  --req-city="Ponta Delgada" \
  --req-org="ENTA - Escola de Novas Tecnologias" \
  --req-email=webmaster@enta.pt \
  --req-ou="Departamento de Informatica" \
  --req-cn="*.amazonaws.com" \
  --subject-alt-name="DNS:*.amazonaws.com" \
  build-server-full amazonaws.com nopass
## Build-Client-full
./easyrsa \
  --batch \
  --dn-mode=org \
  --req-c=PT \
  --req-st=Azores \
  --req-city="Ponta Delgada" \
  --req-org="ENTA - Escola de Novas Tecnologias" \
  --req-email=webmaster@enta.pt \
  --req-ou="Departamento de Informatica" \
  --req-cn="*.amazonaws.com" \
  --subject-alt-name="DNS:*.amazonaws.com" \
  build-client-full client.amazonaws.com nopass
## Create P12
echo "Passw0rd" > /tmp/P12Password
./easyrsa --passout=file:/tmp/P12Password export-p12 client.amazonaws.com
## Copy the certificates
cp pki/ca.crt /etc/ssl/certs
chmod +r /etc/ssl/certs/ca.crt
cp pki/issued/amazonaws.com.crt /etc/ssl/certs
chmod +r /etc/ssl/certs/amazonaws.com.crt
cp pki/private/ca.key /etc/ssl/private
chmod g+r /etc/ssl/private/ca.key
chgrp ssl-cert /etc/ssl/private/ca.key
cp pki/private/amazonaws.com.key /etc/ssl/private
chmod g+r /etc/ssl/private/amazonaws.com.key
chgrp ssl-cert /etc/ssl/private/amazonaws.com.key
## Change certificates Apache2
cd /etc/apache2/sites-available
sudo sed -i 's|ssl-cert-snakeoil.pem|amazonaws.com.crt.com|g' /etc/apache2/sites-available/default-ssl.conf
sudo sed -i 's|ssl-cert-snakeoil.key|amazonaws.com.key.com|g' /etc/apache2/sites-available/default-ssl.conf
## Put Certificates on Apache2 for download
cp /etc/easy-rsa/easyrsa3/pki/ca.crt /var/www/html
cp /etc/easy-rsa/easyrsa3/pki/issued/amazonaws.com.crt /var/www/html
cp /etc/easy-rsa/easyrsa3/pki/issued/client.amazonaws.com.crt /var/www/html
cp /etc/easy-rsa/easyrsa3/pki/private/amazonaws.com.key /var/www/html
cp /etc/easy-rsa/easyrsa3/pki/private/client.amazonaws.com.key /var/www/html
cp /etc/easy-rsa/easyrsa3/pki/private/client.amazonaws.com.p12 /var/www/html
## Change permissions and remove the index
sudo chmod -R +r /var/www/html
sudo rm /var/www/html/index.html
## Install iptables
sudo apt -y install iptables-persistent netfilter-persistent
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save
## Change sysctl
sed -i 's|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|g' /etc/sysctl.conf
sysctl -p
