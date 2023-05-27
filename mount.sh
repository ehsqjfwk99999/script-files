#!/usr/bin/env bash
set -e

GREEN="\e[32m"
ENDCOLOR="\e[0m"

DEVICE_PATH="/dev/nvme0n1"
MOUNT_PATH="/mnt/fio_test"

echo

# check root
[ $(whoami) != "root" ] && echo -e "Login as root first ... Exit\n" && exit

# Check device path
echo -n "Checking device path ... "
! [ -b $DEVICE_PATH ] && echo -e "Error: no device path ... Exit\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

# check mount path
echo -n "Checking mount path ... "
! [ -d $MOUNT_PATH ] && echo -n "Creating ... " && mkdir -p $MOUNT_PATH
echo -e "${GREEN}Done${ENDCOLOR}"

# mkfs
echo -n "mkfs ... "
mkfs.ext4 -F $DEVICE_PATH
[ $? != 0 ] && echo -e "Failed: mkfs ... Exit\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

# mount
echo -n "mount ... "
# mount "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o notreelog,commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
mount $DEVICE_PATH $MOUNT_PATH
[ $? != 0 ] && echo -e "Failed: mount ... Exit\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

echo -e "\n${GREEN}Mount Complete!${ENDCOLOR}\n"
