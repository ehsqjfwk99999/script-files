#!/usr/bin/env bash
set -e

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

DEVICE_PATH="/dev/nvme0n1"
MOUNT_PATH="/mnt/fio_test"

echo

# check root
[ $(whoami) != "root" ] && echo -e "${RED}Login as root first ... Exit${ENDCOLOR}\n" && exit

# Check device path
echo -n "Checking device path ... "
! [ -b $DEVICE_PATH ] && echo -e "${RED}Error: no device path ... Exit${ENDCOLOR}\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

# check mount path
echo -n "Checking mount path ... "
! [ -d $MOUNT_PATH ] && echo -n "Creating ... " && mkdir -p $MOUNT_PATH
echo -e "${GREEN}Done${ENDCOLOR}"

# mkfs
echo -n "mkfs ... "
mkfs.ext4 -F $DEVICE_PATH
[ $? != 0 ] && echo -e "${RED}Failed: mkfs ... Exit${ENDCOLOR}\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

# mount
echo -n "mount ... "
# mount "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o notreelog,commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
mount $DEVICE_PATH $MOUNT_PATH
[ $? != 0 ] && echo -e "${RED}Failed: mount ... Exit${ENDCOLOR}\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

echo -e "\n${GREEN}Mount Complete!${ENDCOLOR}\n"
