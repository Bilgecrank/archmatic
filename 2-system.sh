#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

create_user() {
	logprint "Creating main user"

	useradd -m -G wheel -s /bin/bash "$USERNAME"
	echo "$USERNAME:$PASSWORD" | chpasswd
	
	logprint "${USERNAME} created"
}

wheel_shall_not_pass() {
	logprint "Making wheel no pass sudo"

	cat<<-EOF > /etc/sudoers.d/wheel
	%wheel ALL=(ALL:ALL) NOPASSWD: ALL
	EOF

	logprint "wheel does what it wants now"
}

enable_multilib() {
	logprint "Enabling multilib for 32-bit packages"

	cat<<-EOF > /etc/pacman.d/multilib
	[multilib]
	Include = /etc/pacman.d/mirrorlist
	EOF

	logprint "Multilib enabled, steam can be installed"
}

install_packages() {
	logprint "Install ArchLinux packages"
	
	mapfile -t args < <(cat pkg-lists/system.txt)
	pacman -S "${args[@]}" --noconfirm --needed
	
	logprint "Finished installing ArchLinux packages"
}

install_packages_asdeps() {
	logprint "Install ArchLinux package optionals"
	
	mapfile -t args < <(cat pkg-lists/deps.txt)
	pacman -S "${args[@]}" --noconfirm --needed --asdeps
	
	logprint "Finished installing ArchLinux packages optionals"
}

create_user
wheel_shall_not_pass
enable_multilib
install_packages
install_packages_asdeps

