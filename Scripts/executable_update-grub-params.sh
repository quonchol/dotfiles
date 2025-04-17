#!/bin/bash

GRUB_FILE="/etc/default/grub"
BACKUP_FILE="/etc/default/grub.bak.$(date +%F-%H%M%S)"

# Parameters to add
PARAMS=("acpi_backlight=native" "ipv6.disable=1")

# Backup original file
echo "Backing up $GRUB_FILE to $BACKUP_FILE"
cp "$GRUB_FILE" "$BACKUP_FILE"

# Read the existing line
ORIGINAL_LINE=$(grep '^GRUB_CMDLINE_LINUX_DEFAULT=' "$GRUB_FILE")

# Remove leading/trailing quotes and extract content
LINE_CONTENT=$(echo "$ORIGINAL_LINE" | sed -E 's/GRUB_CMDLINE_LINUX_DEFAULT="(.*)"/\1/')

# Append missing parameters
for param in "${PARAMS[@]}"; do
    if [[ "$LINE_CONTENT" != *"$param"* ]]; then
        LINE_CONTENT="$LINE_CONTENT $param"
    fi
done

# Clean up extra spaces
LINE_CONTENT=$(echo "$LINE_CONTENT" | xargs)

# Replace the line in the grub file
NEW_LINE="GRUB_CMDLINE_LINUX_DEFAULT=\"$LINE_CONTENT\""
sed -i "s|^GRUB_CMDLINE_LINUX_DEFAULT=.*|$NEW_LINE|" "$GRUB_FILE"

echo "Updated GRUB_CMDLINE_LINUX_DEFAULT to:"
echo "$NEW_LINE"

# Prompt to update grub and update
sudo grub-mkconfig -o /boot/grub/grub.cfg
