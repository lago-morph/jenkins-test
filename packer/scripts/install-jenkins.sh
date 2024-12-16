#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt install fontconfig openjdk-21-jre -y
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
      https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

# Add jenkins uer to docker group if docker has been installed
# I don't use "&&" version because I don't want to return error exit code if this runs first
if dpkg -l docker.io &> /dev/null; then
       	sudo usermod -aG docker jenkins
fi
