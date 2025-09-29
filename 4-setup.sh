#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

configure_system() {
	logprint "Setup post install of packages"
	
	
	logprint "Enable bluetooth"
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
	
	logprint "Enabling cups"
	systemctl enable org.cups.cupsd.service
	systemctl start org.cups.cupsd.service
	
	logprint "Rebooting"
	sudo systemctl reboot
}
