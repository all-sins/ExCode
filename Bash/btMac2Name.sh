#!/bin/bash

# Filename to store MAC addresses
file="bluetooth_devices.txt"

# Check if the file exists, create it if not
if [ ! -e "$file" ]; then
    touch "$file"
fi

# Clear the file contents
> "$file"

# Regular expression to match MAC addresses
regex='(?<=\s)[[:xdigit:]]++:[[:xdigit:]]++:[[:xdigit:]]++:[[:xdigit:]]++:[[:xdigit:]]++:[[:xdigit:]]++(?=\s)'

# Run scanning for 5 seconds and store the unique MAC addresses in a file
timeout 5s bluetoothctl scan on | grep "Device" | sort -u > "$file"

# Disable scanning
echo -e 'scan off\n' | bluetoothctl

# Extract MAC addresses using the regex and display device names
while IFS= read -r line; do
    mac=$(echo "$line" | grep -oP "$regex")
    if [ -n "$mac" ]; then
        echo "MAC: $mac"
        echo -e "info $mac\n" | bluetoothctl
    fi
done < "$file"

# Quit bluetoothctl
echo -e 'quit\n' | bluetoothctl

