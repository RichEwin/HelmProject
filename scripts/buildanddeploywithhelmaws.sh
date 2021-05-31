#!/bin/sh

set -e

# colorcode variables
GREEN="\033[0;32m"
EC="\033[0m"

# application variables
application="video-blog"
tag="latest"

# aws variables
ECR_REGISTRY_ID="147415201944"
AWS_REGION="eu-west-2"

# helm variables
helmname="video-blog"
CHARTNAME="video-blog"

echo "${GREEN}Logging into AWS ECR${EC}"
aws ecr get-login-password --region ${AWS_REGION}| docker login --username AWS --password-stdin ${ECR_REGISTRY_ID}.dkr.ecr.${region}.amazonaws.com

echo "${GREEN}Building ${application}${EC}"
docker build -t ${application} .

echo "${GREEN}Running ${application}${EC}"
docker run -p 3000:3000 -d ${application}

echo "${GREEN}Tagging ${application}${EC}"
docker tag ${application} ${ECR_REGISTRY_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${application}:${tag}

echo "${GREEN}Pushing ${application} to AWS ECR${EC}"
docker push ${ECR_REGISTRY_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${application}:${tag}

echo "${GREEN} Template ${application} chart${EC}"

helm template --debug ${application} ${application}
echo " "

echo "${GREEN}Deploying ${application} using Helm${EC}"
helm install ${helmname} ${helmchart} 

echo "${GREEN}Release Successful${EC}"




