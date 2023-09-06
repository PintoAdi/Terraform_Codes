#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
sudo systemctl status nginx.service
sudo chmod 007 /usr/share/nginx/html
sudo mkdir /usr/share/nginx/html/drive
sudo cp /usr/share/nginx/html/index.html /usr/share/nginx/html/drive
PVTIP=`curl -sL http://169.254.169.254/latest/meta-data/local-hostname`
echo "This is drive page" >> /usr/share/nginx/html/index.html
echo "<h1>$PVTIP<h1>" >> /usr/share/nginx/html/drive/index.html