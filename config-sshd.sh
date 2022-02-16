#!/usr/bin/env bash

sudo true # should be run as root

# enable ssh root login
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
# allow ssh password autientication
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

sudo systemctl restart ssh # apply configuration change
