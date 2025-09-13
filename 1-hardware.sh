#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

printf "
###################################
Install microcode and drivers
###################################

"

PKGS=(
	intel-ucode
	mesa
)

for PKG in "${PKGS[@]}"; do
    printf "Installing: %s\n" "$PKG"
    sudo pacman -S "$PKG" --noconfirm --needed
done

printf "
#####
Done!
#####

"
