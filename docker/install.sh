#!/bin/bash
set -x
source sys/common.sh
source sys/distro.sh


apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Ubuntu
if [ "$OS" == "Ubuntu" ]; then
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
# Debian
elif [ "$OS" == "Debian" ]; then
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"
# Everything elese...
else
    echo "OS $OS not supported!"
    exit 1
fi

apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

read -p 'Add username to Docker group [system username or empty to skip]:' username

if [ ! -z $username ]; then
    usermod -aG docker $username
fi
