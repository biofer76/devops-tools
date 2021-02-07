#!/bin/bash
set -e
export OS
export VER

#----------# FUNCTIONS #----------#
message (){
    echo "(!)devops-tools> $1"
    sleep 1
}
ask (){
    read -p "(?)devops-tools> $1 " input_value
    echo $input_value
}
ask_yn (){
    while true; do
        read -p "(?)devops-tools> $1 [y/n]: " -n 1 -r yn 
        echo
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) message "Exit."; exit;;
            * ) message "Please answer y or n";;
        esac
    done
}
#----------# DISTRO #----------#
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi
# Check OS and exit if not supported
case "$OS" in
    Ubuntu | Debian)
        message "DevOps Tools v0.1 on $OS $VER"
        ;;
    *)
        message "OS $OS is not supported."
        exit 1
        ;;
esac
# Check if user is root
if [ `whoami` == "root" ]; then
    message "You must not be root to run commands, switch to regular sudoers user."
    exit
fi
#----------# CONFIRM RUNNING #----------#
CMD=$0
IFS='/'
read -ra CMD_SPLIT <<< "$CMD"
CMD_SERVICE=${CMD_SPLIT[0]}
CMD_ACTION=${CMD_SPLIT[1]}
ask_yn "Confirmation before starting: ${CMD_ACTION%.sh} for $CMD_SERVICE"