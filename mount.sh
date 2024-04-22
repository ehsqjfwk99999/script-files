#!/usr/bin/env bash
set -e

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

DEVICE_PATH="/dev/nvme0n1"
MOUNT_PATH="/mnt/fio_test"

echo
echo -e "${GREEN}Mount Device!${ENDCOLOR}"

# select filesystem
echo "1) Ext4"
echo "2) F2FS"
read -p "Select filesystem [Ext4] " fs
if [ ${fs:=1} -eq 1 ]; then
    fs=ext4
elif [ $fs -eq 2 ]; then
    fs=f2fs
else
    fs=ext4
fi
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
if [ $fs == "ext4" ]; then
    mkfs.ext4 -F $DEVICE_PATH
elif [ $fs == "f2fs" ]; then
    mkfs.f2fs -f $DEVICE_PATH
fi
[ $? != 0 ] && echo -e "${RED}Failed: mkfs ... Exit${ENDCOLOR}\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

# mount
echo -n "mount ... "
mount $DEVICE_PATH $MOUNT_PATH
[ $? != 0 ] && echo -e "${RED}Failed: mount ... Exit${ENDCOLOR}\n" && exit
echo -e "${GREEN}Done${ENDCOLOR}"

echo -e "\n${GREEN}Mount Complete!${ENDCOLOR}\n"

## [Backup] ####################################################################

# BTRFS mount options
# mount "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
# mount -o notreelog,commit=10 "${DEVICE_PATH}" "${MOUNT_PATH}" &> /dev/null
