#!/usr/bin/env bash
set -e

GREEN="\e[32m"
ENDCOLOR="\e[0m"

DEVICE_PATH="/dev/nvme0n1"

echo

# unmount device
echo -n "Unmount device ... "
umount $DEVICE_PATH
echo -e "${GREEN}Done${ENDCOLOR}"

echo -e "\n${GREEN}Unmount Complete!${ENDCOLOR}\n"
