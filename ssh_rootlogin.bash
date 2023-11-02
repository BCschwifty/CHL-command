#!/bin/bash

# Check if whiptail is available
if ! command -v whiptail &> /dev/null; then
    echo "Whiptail is not installed. Please install it to use this script."
    exit 1
fi

# Display a yes/no dialog
if whiptail --yesno "Do you want to enable root login over SSH?" 10 40; then
    # Uncomment the PermitRootLogin line
    if grep -q '^#PermitRootLogin' /etc/ssh/sshd_config; then
        sed -i 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
        service ssh restart
        whiptail --msgbox "Root login over SSH enabled." 10 40
    else
        whiptail --msgbox "Root login is already enabled in the SSH configuration." 10 40
    fi
else
    whiptail --msgbox "Root login over SSH remains disabled." 10 40
fi
