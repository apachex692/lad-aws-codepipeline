#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 05/10/2023
sudo yum -y upgrade && sudo yum -y install docker.x86_64 python3-pip

sudo usermod -a -G docker ec2-user
newgrp docker

pip3 install --user docker-compose

sudo systemctl start docker && sudo systemctl enable docker
