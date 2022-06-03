#!/usr/bin/env bash

sudo true # should be run as root

# enable IPv4 packet forwarding
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf

sysctl -p # load sysctl settings from `/etc/sysctl.conf`
