#!/usr/bin/env bash

#------------------------------------\
#             _             _   _     \
# ___ ___ ___| |_ _____ ___| |_|_|___  \
#| .'|  _|  _|   |     | .'|  _| |  _| /
#|__,|_| |___|_|_|_|_|_|__,|_| |_|___|/
#------------------------------------/

. ./utils.sh

logprint "Format a block device and prepare it"

# Formats the block device and prepares it to be bootable with LVM.
function format-disk() {
	block_dev="$1"
	gibibyte="$((1024 ** 3))"
	block_dev_size=$(blockdev --getsize64 "$block_dev")
	
	# boot drive no more than 4GiB or 5% the drive, no less than 1GiB
	raw_boot_size=$((block_dev_size * 5 / 100))
	raw_boot_size=$((raw_boot_size > (4 * gibibyte) ? (4 * gibibyte) : raw_boot_size ))
	raw_boot_size=$((raw_boot_size > gibibyte ? gibibyte : raw_boot_size ))

	boot_part_size=$((raw_boot_size / 1024)) # to Kibibytes.
	sgdisk -Z "$block_dev"
	sgdisk -o "$block_dev"
	
	sgdisk -n 1:0:+"$boot_part_size"K \
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


	root_size=$((block_dev_size * 10 / 100 / 1024))
	lvcreate -L "$root_size"K vg0 -n root
	mkfs.ext4 /dev/vg0/root


	home_size=$((block_dev_size * 50 / 100 / 1024))
	lvcreate -L "$home_size"K vg0 -n home
	mkfs.ext4 /dev/vg0/home

	# Setup is not geared to hibernation, maximum 10 gibibytes, minimum 1 gibibyte.
	raw_swap_size=$((block_dev_size * 5 / 100))
	raw_swap_size=$((raw_swap_size > (10 * gibibyte) ? (10 * gibibyte) : raw_swap_size ))
	raw_swap_size=$((raw_swap_size > gibibyte ? gibibyte : raw_swap_size ))

	swap_size=$((raw_swap_size / 1024)) # to Kibibytes.
	lvcreate -L "$swap_size"K vg0 -n swap
	mkswap /dev/vg0/swap

	mount /dev/vg0/root /mnt
	mount --mkdir "${block_dev}1" /mnt/boot
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
printf "Please enter disk to work on: (example /dev/sda)\n"
read -r input

logprint "$input"
if test -b "$input"; then
  logprint "Formatting and preparing $input for Arch"
  format-disk "$input"
  logprint "done!"
else
  logprint "$input is not a block device"
fi
