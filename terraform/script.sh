#!/bin/bash
sudo apt update
yes | sudo  DEBIAN_FRONTEND=noninteractive apt install -y docker.io awscli
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod 777 /usr/local/bin/docker-compose
sudo usermod -aG docker ubuntu
mkdir /home/ubuntu/interview_techverito
cd /home/ubuntu/interview_techverito
sudo chown -R ubuntu:ubuntu /home/ubuntu/interview_techverito
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 427510603539.dkr.ecr.ap-south-1.amazonaws.com

