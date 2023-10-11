# AWS CodeDeploy Testing

A project used to test the AWS CodePipeline (CodeBuild and CodeDeploy). This project runs Docker containers that host a Flask app proxied by Nginx.

- **Author:** Sakthi Santhosh
- **Created on:** 05/10/2023

## Pre-requisites

1. Ensure that AWS CLI is installed in your system and its credentials configured with the right permissions.
2. The S3 bucket that you're uploading the deployment package to must have versioning enabled as CodeDeploy requires it.

## Instructions

### Project

1. Update the sub-module by running `git submodule init` and `git submodule update` which installs the Flask and Nginx Docker build/configuration files in the `/project/` directory.
2. To start, compress the project into a `.zip` file and upload it to AWS S3 with the command: `./scripts/pack.sh <bucket-name>`.

### AWS Management Console: IAM

1. Add the following roles to IAM and ensure that it is assigned to the services later:
    1. `AWSCodeDeployRole`
         1. **Required by:** AWS CodeDeploy
         2. **Attach on:** Application Creation
    2. `AmazonEC2RoleforAWSCodeDeploy` and `AmazonSSMManagedInstanceCore`
         1. **Required by:** AWS EC2
         2. **Attach on:** Launch or Stopped Instance
2. The CodeBuild role can be created during the creation of a build project. However this project requires additional policies to authorize and write container images to ECR. Hence attach the following policy to the same role after it is created:
    1. `AmazonEC2ContainerRegistryPowerUser`
        1. **Required by:** AWS CLI Running on CodeBuild Image to Authorize Docker to ECR
        2. **Attach on:** Newly Created Role by CodeBuild in IAM Console

### AWS Management Console: EC2

1. Create instances in the EC2 Console. Make sure to use Amazon Linux-2 as the AMI because it comes with AWS System Manager Agent pre-installed.
2. You can install the CodeDeploy Agent with the AWS System Manager Console on your EC2 Instances or you can let the CodeDeploy do it on your behalf.
3. Give a name to your EC2 Instance(s) which will be later used for setting up the environment for CodeDeploy to perform its deployment.

### AWS Management Console: CodeDeploy

1. Navigate to CodeDeployment → Applications and create a new application for deployment.
2. Under the new application, create a deployment group. This is where we specify the environment for deployment, which is, the EC2 instance.
3. Once a deployment group is created, create a deployment on the same console by clicking the "Create Deployment" button.
4. Specify the deployment package (S3 here) and create deployment. Monitor the deployment as it rolls out.

## System Information

### Host: System

- **Operating System:** GNU/Linux (x86_64)
- **Distribution:** Debian 11 Bullseye
- **Kernel Version:** 6.1.52-1

### Host: Tools

- **Docker:** 24.0.6 (ed223bc)
- **Python:** 3.11.2

### Deployment Environment: System

- **Operating System:** GNU/Linux (x86_64)
- **Distribution:** Amazon Linux-2
- **Kernel Version:** 6.1.52-1
