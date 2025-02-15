#!/bin/bash
#install nginx
sudo apt-get update
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
sudo apt-get install git -y





