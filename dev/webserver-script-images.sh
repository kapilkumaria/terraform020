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
mkdir /var/www/html/images
touch /var/www/html/images/image1 /var/www/html/images/image2 /var/www/html/images/image3
echo "<html><h1>This is Image # 1</h1></html>" > /var/www/html/images/image1
echo "<html><h1>This is Image # 2</h1></html>" > /var/www/html/images/image2
echo "<html><h1>This is Image # 3</h1></html>" > /var/www/html/images/image3
echo "<html><h1>Testing the Apache Web Server Launching Sucessfully from $(hostname -f)</h1></html>" > /var/www/html/index.html

