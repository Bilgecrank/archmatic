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
Install audio components
##########################

"

PKGS=(
	'pipewire' # Low-latency audio/video router and processor

)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

printf "
#####
Done!
#####

"
