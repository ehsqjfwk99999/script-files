#!/usr/bin/env bash

echo "Download Linux Kernel!"
read -p "version: " version

[ -z $version ] && echo -e "\nPlease enter version ... Exit" && exit

major=$(echo $version | cut -d "." -f 1)

# ex) https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-6.2.tar.xz
curl -LO "https://mirrors.edge.kernel.org/pub/linux/kernel/v$major.x/linux-$version.tar.xz"
