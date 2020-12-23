#!/bin/bash

#############################################################
####### USE THIS USER_DATA WITH APACHE WEB SERVER ###########
#############################################################

# Get Admin Privileges

sudo su

# Install Apache2 Web Server 

apt update -y
apt install awscli -y
apt install apache2 -y
service apache2 start
service apache2 enable
mkdir /var/www/html/logfiles
touch /var/www/html/logfiles/log1 /var/www/html/logfiles/log2 /var/www/html/logfiles/log3
echo "This is Logfile # 1" > /var/www/html/logfiles/log1
echo "This is Logfile # 2" > /var/www/html/logfiles/log2
echo "This is Logfile # 3" > /var/www/html/logfiles/log3
echo "<html><h1>Testing the Apache Web Server Launching Sucessfully from $(hostname -f)</h1></html>" > /var/www/html/index.html
