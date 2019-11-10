#!/bin/sh

set -eu

main () {
    lsblk

    read -rp 'Which disk should be partitioned? ' disk

    fdisk "$disk"

    read -rp 'Which partition to install Arch Linux on? ' partition

    partition="${disk}${partition}"

    mkfs.ext4 "$partition"

    mount "$partition" /mnt

    pacstrap /mnt base linux-lts grub dhcpcd

    arch-chroot /mnt <<EOF
grub-install "$disk"
grub-mkconfig -o /boot/grub/grub.cfg
EOF
}

main "$@"
