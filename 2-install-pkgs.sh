#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

logprint "Install ArchLinux packages"

mapfile -t args < <(cat pkg-lists/*)
sudo pacman -S "${args[@]}" --noconfirm --needed

logprint "Finished installing ArchLinux packages"

