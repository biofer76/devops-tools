#!/bin/bash
source common/start.sh
#----------# START SCRIPT #----------#

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update
TERRAFORM_VER=$(sudo apt-cache policy terraform | grep Candidate | cut -d ":" -f 2)
message "Install Terraform version: $TERRAFORM_VER"
sudo apt-get install terraform

#----------# END SCRIPT #----------#
source common/end.sh