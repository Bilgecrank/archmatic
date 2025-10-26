#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

if test -t 0; then
	logprint 'Please provide username and password through stdin' >&2
	exit 1
fi

read -r USERNAME PASSWORD

if test -z password; then
	logprint 'Please provide a second input for the password (ex: echo "username password")' >&2
	exit 1
fi

export USERNAME
export PASSWORD

bash 1-pre-install.sh |& tee -a "$logfile"
arch-chroot /mnt git clone https://github.com/Bilgecrank/archmatic.git |& tee -a "$logfile"
arch-chroot /mnt "${HOME}/archmatic/2-system.sh" |& tee -a "$logfile"
arch-chroot /mnt /usr/bin/runuser -u "$USERNAME" -- git clone https://github.com/Bilgecrank/archmatic.git |& tee -a "$logfile"
arch-chroot /mnt /usr/bin/runuser -u "$USERNAME" -- "${HOME}/archmatic/3-user.sh" |& tee -a "$logfile"
arch-chroot /mnt /usr/bin/runuser -u "$USERNAME" -- "${HOME}/archmatic/4-setup.sh" |& tee -a "$logfile"
