#!/usr/bin/env bash

#-------------------------------------------------------------------------
#      _          _    __  __      _   _    
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__ 
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__| 
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

. ./utils.sh

printf "
archmatic: Configure pre-installation

"

# Formats the block device and prepares it to be bootable with LVM.
function format-disk() {
	block_dev="$1"
	sgdisk -Z "$block_dev"
	sgdisk -o "$block_dev"
	
	sgdisk -n 1:0:+3814M \
		-t 1:ef00 \
		-c 1:"EFI System Partition" \
		"$block_dev"
	sgdisk -n 2:0:0 \
		-t 2:8e00 \
		-c 2:"Linux LVM Partition" \
		"$block_dev"
	
	mkfs.fat -F 32 "${block_dev}1"
	
	pvcreate "${block_dev}2"
	vgcreate vg0 "${block_dev}2"

	lvcreate -L 100G -n root
	mkfs.ext4 /dev/vg0/root
	lvcreate -L 500G -n home
	mkfs.ext4 /dev/vg0/home
	lvcreate -L 10G -n swap
	mkswap /dev/vg0/swap

	mount /dev/vg0/root /mnt
	mount --mkdir "/dev/${block_dev}1" /mnt/boot
	mount --mkdir /dev/vg0/home /mnt/home
	swapon /dev/vg0/swap

	pacstrap /mnt base base-devel linux linux-firmware nvim sudo --noconfirm --needed
	genfstab -U /mnt >> /mnt/etc/fstab

	root_uuid=$(blkid /dev/vg0/root -s UUID -o value)
	bootctl install --esp-path=/mnt/boot
	mkdir -p /mnt/boot/loader/entries
	cat <<-EOF > /mnt/boot/loader/entries/arch.conf
	title Arch Linux  
	linux /vmlinuz-linux  
	initrd  /initramfs-linux.img  
	options root=UUID=${root_uuid} rw
	EOF

	# Set hooks for mkinitipio to include lvm2
	cat <<-EOF > /etc/mkinitcpio.conf.d/hooks.conf
	HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block lvm2 filesystems fsck)
	EOF
}

lsblk -p | grep disk
echo "Please enter disk to work on: (example /dev/sda)"
read -r input

logprint "$input"
if test -b "$input"; then
  logprint "Formatting and preparing $input for Arch"
  format-disk "$input"
  logprint "done!"
else
  logprint "$input is not a block device"
fi
