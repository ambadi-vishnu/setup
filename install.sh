#!/bin/bash

#Create Log File
touch ~/install-log.txt || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Creating Install Log File" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Install Log File Created" >> ~/install-log.txt

#Create Temp Directory
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Creating Temp Directory..." >> ~/install-log.txt
mkdir -p ~/temp || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Creating Temp Directory" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Created Temp Directory" >> ~/install-log.txt

#Change Directory - Temp
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Changing Directory..." >> ~/install-log.txt
cd ~/temp || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Changing Directory" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Switched To Temp Directory" >> ~/install-log.txt

#Clone Dotfiles Repository
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Cloning ambadi-vishnu/dotfiles.git..." >> ~/install-log.txt
git clone https://github.com/ambadi-vishnu/dotfiles.git || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Cloning ambadi-vishnu/dotfiles.git" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Cloning Complete - ambadi-vishnu/dotfiles.git" >> ~/install-log.txt

#Change Directory - Home
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Switching To Home Directory..." >> ~/install-log.txt
cd ~ || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Switching To Home Directory" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Switched To Home Directory" >> ~/install-log.txt

#Script Permission Update
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Updating Script Permissions..." >> ~/install-log.txt
chmod +x ~/temp/dotfiles/custom/scripts/* || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Updating Script Permissions" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Script Permissions Updated" >> ~/install-log.txt

#Executing Script
echo "$(date '+%A %d %B %Y | %I:%M %p'): Message: Starting Installation Script Execution..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script update.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/update.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script update.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script update.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script yay.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/yay.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script yay.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script yay.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script mirror.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/mirror.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script mirror.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script mirror.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script mkinit.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/mkinit.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script mkinit.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script mkinit.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script hyprland.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/hyprland.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script hyprland.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script hyprland.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script pacman.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/pacman.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script pacman.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script pacman.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script aur.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/aur.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script aur.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script aur.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script python.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/python.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script python.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script python.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script grub.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/grub.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script grub.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script grub.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script sddm.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/sddm.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script sddm.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script sddm.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script mtp.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/mtp.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script mtp.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script mtp.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script dolphin.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/dolphin.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script dolphin.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script dolphin.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script config.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/config.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script config.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script config.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script theme.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/theme.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script theme.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script theme.sh" >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script actions.sh..." >> ~/install-log.txt
~/temp/dotfiles/custom/scripts/actions.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script actions.sh" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script actions.sh" >> ~/install-log.txt

#Change Shell - ZSH
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Changing Shell..." >> ~/install-log.txt
chsh -s /bin/zsh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Changing Shell" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Shell Changed" >> ~/install-log.txt

#Installation Completed
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Installation Complete. Restart Now. Run Post Installation Scripts" >> ~/install-log.txt
echo "Installation Complete. Restart Now"