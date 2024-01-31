#!/usr/bin/env bash

set -euo pipefail

GREEN="\e[32m"
ENDCOLOR="\e[0m"

echo -e "${GREEN}Install Golang!${ENDCOLOR}"
read -p "version: " version

[ -z $version ] && echo -e "\nPlease enter version ... Exit" && exit

# ex) https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
curl -LO https://go.dev/dl/go${version}.linux-amd64.tar.gz

go_binary_release=go${version}.linux-amd64.tar.gz

# remove previous binary and unzip new binary (need root privilege)
if [ $(whoami) == 'root' ]; then
    rm -rf /usr/local/go && tar -C /usr/local -xzf ${go_binary_release}
else
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ${go_binary_release}
fi

# clean up
rm -rf ${go_binary_release}

echo
echo -e "${GREEN}Go v${version} installed!${ENDCOLOR}"
echo
echo '-> Test with "export PATH=$PATH:/usr/local/go/bin"'
echo

# export GOROOT=/usr/local/go
# export GOPATH=<go_path>
# export PATH=$PATH:$GOROOT/bin:$GOPATH
