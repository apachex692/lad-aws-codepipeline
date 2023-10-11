#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 06/10/2023
cd ./project/

docker build \
  --tag 007710768743.dkr.ecr.ap-south-1.amazonaws.com/website:nginx-proxy \
  --file ./docker/nginx/Dockerfile \
  ./
docker build \
  --tag 007710768743.dkr.ecr.ap-south-1.amazonaws.com/website:flask-app \
  --file ./docker/flask/Dockerfile \
  ./

aws ecr get-login-password --region ap-south-1 | \
  docker login --username AWS --password-stdin 007710768743.dkr.ecr.ap-south-1.amazonaws.com

docker push 007710768743.dkr.ecr.ap-south-1.amazonaws.com/website:nginx-proxy
docker push 007710768743.dkr.ecr.ap-south-1.amazonaws.com/website:flask-app
