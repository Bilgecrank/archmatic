#!/usr/bin/env bash

#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

printf "
###########################
Configure pre-installation
###########################

"

function format-disk() {
	block_dev="$1"
	sgdisk -Z "$block_dev"
	sgdisk -o "$block_dev"
	
	sgdisk -n 1:0:+3814M \
		-t 1:ef00 \
		-c 1:"EFI System Partition" \
		"$block_dev"
	sgdisk -n 2:0:0 \
		-t 2:8e00 \
		-c 2:"Linux LVM Partition" \
		"$block_dev"
	
	mkfs.fat -F 32 "${block_dev}1"
	
	pvcreate "${block_dev}2"
	vgcreate vg0 "${block_dev}2"

	lvcreate -L 100G -n root
	mkfs.ext4 /dev/vg0/root
	lvcreate -L 500G -n home
	mkfs.ext4 /dev/vg0/home
	lvcreate -L 10G -n swap
	mkswap /dev/vg0/swap

	mount /dev/vg0/root /mnt
	mount --mkdir "/dev/${block_dev}1" /mnt/boot
	mount --mkdir /dev/vg0/home /mnt/home
	swapon /dev/vg0/swap
}

lsblk -p | grep disk
echo "Please enter disk to work on: (example /dev/sda)"
read -r input

if test -b "$input"; then
  printf "Formatting and preparing %s for Arch\n" "$input"
  format-disk "$input"
else
  printf "%s is not a block device\n" "$input"
fi



printf "
#####
Done!
#####

"
