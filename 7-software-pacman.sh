#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

printf "
#########################
Install software binaries
#########################

"
PKGS=(
	
	'alacritty'
	'tmux'
	'nvim'
	'bash-completion'
	'curl'
	'discord'
	'htop'
	'openssh'
	'rsync'
	'unrar'
	'unzip'
	'wget'
	'zenity'
	'gparted'
	'parted'
	'clang'
	'cmake'
	'git'
	'gcc'
	'glibc'
	'npm'
	'python'
	'chromium'
	'firefox'
	'filezilla'
	'mpv'
	'gimp'
	'inkscape'
	'imagemagick'
	'hunspell'
	'hunspell-en'
	'virtualbox'
	'virtualbox-host-modules-arch'
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

printf "
#####
Done!
#####

"
