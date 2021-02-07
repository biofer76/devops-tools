#!/bin/bash
source common/start.sh
#----------# START SCRIPT #----------#

# Packages
message "Remove old Docker packages"
sudo apt-get remove docker docker-engine docker.io containerd runc || true
sudo apt-get update
sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Ubuntu
if [ "$OS" == "Ubuntu" ]; then
    sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"
# Debian
elif [ "$OS" == "Debian" ]; then
    sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/debian \
            $(lsb_release -cs) \
            stable"
# Everything else...
else
    message "OS $OS not supported!"
    exit 1
fi
# Install packages
sudo apt-get update
message "Install Docker packages"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# Add user to Docker group 
username=$(ask "Add user to Docker group [system username or empty to skip]")
if [ ! -z $username ]; then
    message "Set $username to the docker group"
    sudo usermod -aG docker $username
fi

#----------# END SCRIPT #----------#
source common/end.sh