#!/usr/bin/env bash
set -e

GRUB_MODULES="
	all_video
	boot
	btrfs
	cat
	chain
	configfile
	echo
	efifwsetup
	efinet
	ext2
	fat
	font
	gettext
	gfxmenu
	gfxterm
	gfxterm_background
	gzio
	halt
	help
	hfsplus
	iso9660
	jpeg
	keystatus
	loadenv
	loopback
	linux
	ls
	lsefi
	lsefimmap
	lsefisystab
	lssal
	memdisk
	minicmd
	normal
	ntfs
	part_apple
	part_msdos
	part_gpt
	password_pbkdf2
	png
	probe
	reboot
	regexp
	search
	search_fs_uuid
	search_fs_file
	search_label
	sleep
	smbios
	squash4
	test
	true
	video
	xfs
	zfs
	zfscrypt
	zfsinfo
	cpuid
	play
	tpm
	"

grub-mkconfig -o /boot/grub/grub.cfg
#grub-install --target=x86_64-efi --efi-directory=/boot --modules="${GRUB_MODULES}" --sbat /usr/share/grub/sbat.csv --bootloader-id=GRUB
grub-mkstandalone -d /usr/lib/grub/x86_64-efi/ -O x86_64-efi --modules="${GRUB_MODULES}" --sbat /usr/share/grub/sbat.csv -o /boot/EFI/GRUB/grubx64.efi boot/grub/grub.cfg=/boot/grub/grub.cfg
sbsign --key /boot/MOK.key --cert /boot/MOK.crt --output /boot/EFI/GRUB/grubx64.efi /boot/EFI/GRUB/grubx64.efi
