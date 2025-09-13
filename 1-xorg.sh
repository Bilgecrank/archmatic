#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

prinf "
###################################
Setup mirrors and install microcode
###################################

"

PKGS=(
	intel-ucode
)

sudo pacman -Syu

for PKG in "${PKGS[@]}"; do
    printf "Installing: %s\n" "$PKG"
    sudo pacman -S "$PKG" --noconfirm --needed
done

printf "
#####
Done!
#####

"
