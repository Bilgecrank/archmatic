#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

printf "
##########################
Install network components
##########################

"

PKGS=(
        'networkmanager'	# Network connection manager
	'smbclient'		# Samba client
	'cifs-utils'		# Utitlities for mounting samba shares.

)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

printf "
#####
Done!
#####

"
