#!/bin/bash
source common/start.sh
#----------# START SCRIPT #----------#

# Install packages
sudo apt-get install -y bash-completion
# Download Docker completion definition
sudo curl https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
# Include in .bashrc
message "Enable bash completion in .bashrc"
cat << EOF >> ~/.bashrc
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
EOF
# Reload .bashrc
source ~/.bashrc

#----------# END SCRIPT #----------#
source common/end.sh