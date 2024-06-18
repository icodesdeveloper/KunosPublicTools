#!/bin/bash

# Script Information
echo "########################################"
echo "# TryHackMe Attack Box Setup Script    #"
echo "# Made with <3 by Hak69 (2023-2024)    #"
echo "########################################"
echo ""

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Disclaimer
echo "This script will perform the following actions:"
echo "1. Create a user named 'bart'."
echo "2. Modify sudoers files to grant specific permissions."
echo "3. Create and modify files in the /root folder."
echo "We strongly recommend to run this on an empty OS install!"
echo ""
read -r -p "Do you accept these changes? (y/n): " response
if [[ "$response" != "y" ]]; then
    echo "Script execution canceled."
    exit 1
fi




# Function to check if user exists
user_exists() {
    if id "$1" &>/dev/null; then
        return 0  # User exists
    else
        return 1  # User does not exist
    fi
}


# Check if user bart already exists
if user_exists "bart"; then
    read -r -p "User 'bart' already exists. Do you want to delete 'bart' and proceed? (y/n): " response
    if [[ "$response" == "y" ]]; then
        echo -n "Deleting user bart... "
        sudo userdel bart -r &>/dev/null && echo "Done!" || echo "Done!"
    else
        echo "Script execution canceled."
        exit 1
    fi
fi

# Create User bart with password !SolveMe
echo -n "Creating user bart... "
sudo useradd -m -s /bin/bash bart &>/dev/null && echo "Done!" || echo "Failed!"

# Set Password for bart
echo -n "Setting password for bart... "
echo "bart:!SolveMe" | sudo chpasswd &>/dev/null && echo "Done!" || echo "Failed!"

# Ensure bart is not in the sudo group
echo -n "Ensuring bart is not in the sudo group... "
sudo deluser bart sudo &>/dev/null && echo "Done!" || echo "Done!"

# Grant sudo permissions for nano command only
echo -n "Granting sudo privileges for nano to bart... "
echo 'bart ALL=(ALL) NOPASSWD: /usr/bin/nano' | sudo tee /etc/sudoers.d/bart-nano &>/dev/null && echo "Done!" || echo "Failed!"

# Install ncat package
echo -n "Installing ncat package... "
sudo apt -y update &>/dev/null && sudo apt install -y ncat &>/dev/null && echo "Done!" || echo "Failed!"

# Backup original /etc/issue file (optional)
# cp /etc/issue /etc/issue.bak  # Uncomment to create a backup

# Modify /etc/issue with TryHackMe banner
echo -n "Setting custom message in /etc/issue... "
sudo wget -O /etc/issue https://raw.githubusercontent.com/icodesdeveloper/KunosPublicTools/main/2CCS02/101-keystroke-injection/issue &>/dev/null && echo "Done!" || echo "Failed!"

echo ""
echo "########################################"
echo "# Script execution completed!         #"
echo "########################################"
