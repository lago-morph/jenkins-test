#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt install docker.io -y

# add jenkins user to docker group if jenkins has been installed
if dpkg -l jenkins &> /dev/null; then
       	sudo usermod -aG docker jenkins
fi
