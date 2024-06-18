#!/bin/bash

# Script Information
echo "########################################"
echo "# TryHackMe Attack Box Setup Script    #"
echo "# by Gemini (Bard Large Language Model) #"
echo "########################################"
echo ""

# Create User bart with password !SolveMe
echo -n "Creating user bart... "
sudo useradd -m bart &>/dev/null && echo "Done!" || echo "Failed!"

# Set Password for bart
echo -n "Setting password for bart... "
echo "bart:!SolveMe" | sudo chpasswd &>/dev/null && echo "Done!" || echo "Failed!"

# Ensure bart is not in the sudo group
echo -n "Ensuring bart is not in the sudo group... "
sudo deluser bart sudo &>/dev/null && echo "Done!" || echo "Failed!"

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
