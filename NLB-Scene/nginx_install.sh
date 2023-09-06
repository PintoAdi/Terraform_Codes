#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo systemctl start nginx.service
sudo systemctl enable nginx.service
sudo systemctl status nginx.service
PVTIP=$(curl -sL http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h1>$PVTIP</h1>" >> /usr/share/nginx/html/index.html