#!/bin/bash
echo "#> DevOps Tools v0.1"
if [ `whoami` == "root" ]; then
    echo "#> You must not be root to run commands, switch to regular sudoers user."
    exit
fi