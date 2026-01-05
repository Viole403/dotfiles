#!/bin/bash
# Unlock the partitions (Pressing Enter automatically for the blank password)
echo "" | sudo cryptsetup bitlkOpen /dev/sda1 sda1_unlocked
echo "" | sudo cryptsetup bitlkOpen /dev/sda2 sda2_unlocked

# Mount them so Dolphin sees them
sudo mount -o uid=$(id -u),gid=$(id -g) /dev/mapper/sda1_unlocked /mnt/storage_sda1
sudo mount -o uid=$(id -u),gid=$(id -g) /dev/mapper/sda2_unlocked /mnt/storage_sda2
