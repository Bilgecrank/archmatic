#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

printf "
####################
Install sddm and kde
####################

"

PKGS=(
        'sddm'                  # Necessary for plasma
	'sddm-kcm'		# Configuration module for sddm
        'plasma-desktop'        # Minimal plasma desktop
	'plasma-nm'		# Plasma extension for network manager
	'kmix'			# Audio mixer for plasma
	'spectacle'
	'okular'
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

printf "
#####
Done!
#####

"
