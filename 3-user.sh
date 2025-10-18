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

configure_dotfiles() {
	git clone git@github.com:Bilgecrank/.dotfiles.git "${HOME}/.dotfiles"
	stow --dir="${HOME}/.dotfiles" alacritty bash home nvim startship tmux zk
}

configure_system() {
	logprint "Set up the user experience."
	
	logprint "Enable bluetooth"
	sudo systemctl enable bluetooth.service --now
	
	logprint "Enabling cups"
	sudo systemctl enable cups.service --now
	
	logprint "Rebooting"
	sudo systemctl reboot
}

configure_dotfiles || exit
configure_system || exit
