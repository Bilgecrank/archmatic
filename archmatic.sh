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

read -r username password

if test -z password; then
	logprint 'Please provide a second input for the password (ex: echo "username password")' >&2
	exit 1
fi

bash 1-pre-install.sh |& tee "$logfile"


