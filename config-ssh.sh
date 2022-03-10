#!/usr/bin/env bash

sudo true # should be run as root

#=============#
# sshd config #
#=============#
# enable ssh root login
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# allow ssh password autientication
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sudo systemctl restart ssh # apply sshd configuration change

#============#
# ssh config #
#============#
# automatically add host to '~/.ssh/known_hosts' without asking
sudo sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
