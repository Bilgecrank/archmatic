#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

logprint "Install Arch User Repository packages"

install_rua() {
	logprint "Installing rua"
	git clone https://aur.archlinux.org/rua.git
	cd rua || return
	makepkg -sirc
	logprint "Installed rua"
}

logprint "Installing Arch User Repository packages with rua"
mapfile -t args < <(cat pkg-lists/*)
rua install "${args[@]}"

logprint "Finished installing Arch User Repository packages"

