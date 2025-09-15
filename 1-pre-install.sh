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
lsblk -p | grep disk
echo "Please enter disk to work on: (example /dev/sda)"
read block_dev



function format-disk() {
	sgdisk -Z "$1"
}


printf "
#####
Done!
#####

"
