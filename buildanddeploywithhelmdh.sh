#!/bin/sh

set -e

# colorcode variables
green="\033[0;32m"
ec="\033[0m"

# application variables
application="video-blog"
tag="latest"
port="3000:3000"

# dockerhub variables
account="richewin"

# helm variables
chartname="video-blog"

echo "${green}Building ${application}${ec}"
docker build -t ${application} .

echo "${green}Running ${application}${ec}"
docker run -p ${port} -d ${application}

echo "${green}Tagging ${applicacdtion}${ec}"
docker tag ${application} richewin/${application}:${tag}

echo "${green}Pushing ${application} to DockerHub${ec}"
docker push ${account}/${application}:${tag}

echo "${green} Rendering ${application} helm chart${ec}"

helm template --debug ${application}
echo " "

echo "${green}Deploying ${application} using Helm${ec}"
helm install ${chartname} --generate-name

echo "${green}Release Successful${ec}"




