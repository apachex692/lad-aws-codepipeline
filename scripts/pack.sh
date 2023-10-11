#!/bin/bash
#
# Author: Sakthi Santhosh
# Created on: 05/10/2023

zip -r ./deployment.zip ./ -x "*.git*"
aws s3 cp ./deployment.zip s3://$1/deployment.zip
