#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

if test -z "$ARCHUSER"; then
	logprint 'Please provide username by exporting ARCHUSER.' >&2
	exit 1
fi

if test -z "$ARCHPASS"; then
	logprint 'Please provide password by exporting ARCHPASS.' >&2
	exit 1
fi

bash 1-pre-install.sh |& tee -a "$logfile"
arch-chroot /mnt git clone https://github.com/Bilgecrank/archmatic.git /root/archmatic |& tee -a "$logfile"
arch-chroot /mnt "${HOME}/archmatic/2-system.sh" |& tee -a "$logfile"
arch-chroot /mnt /usr/bin/runuser -u "$ARCHUSER" -- git clone https://github.com/Bilgecrank/archmatic.git |& tee -a "$logfile"
arch-chroot /mnt /usr/bin/runuser -u "$ARCHUSER" -- "${HOME}/archmatic/3-user.sh" |& tee -a "$logfile"
