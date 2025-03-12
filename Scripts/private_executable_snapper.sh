#!/bin/bash

# Install required packages
sudo pacman -S --noconfirm snapper snap-pac grub-btrfs

# Create snapper configuration for root
sudo snapper -c root create-config /

# Enable and start snapper timeline service
sudo systemctl enable --now snapper-timeline.timer

# Configure grub-btrfs for Snapper
sudo mkdir -p /etc/systemd/system/grub-btrfsd.service.d/
echo '[Service]
ExecStart=
ExecStart=/usr/bin/grub-btrfsd --syslog' | sudo tee /etc/systemd/system/grub-btrfsd.service.d/override.conf

# Enable and start grub-btrfsd service
sudo systemctl daemon-reload
sudo systemctl enable --now grub-btrfsd

# Create initial snapshot
sudo snapper -c root create --description "Initial snapshot"

# Update GRUB configuration
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Update grub menu
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "Snapper installation and configuration complete."
