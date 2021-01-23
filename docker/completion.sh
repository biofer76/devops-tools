#!/bin/bash
source sys/common.sh
source sys/distro.sh

read -p "#> Configure Docker bash completion for logged user [y/n]:  " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi
echo "#> Install packages"
sudo apt-get install -y bash-completion

echo "#> Enable bash completion in .bashrc"
cat << EOF >> ~/.bashrc
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi
EOF

source ~/.bashrc