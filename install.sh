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
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Cloning mady-codes/dotfiles.git..." >> ~/install-log.txt
git clone https://github.com/mady-codes/dotfiles.git || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Cloning mady-codes/dotfiles.git" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Cloning Complete - mady-codes/dotfiles.git" >> ~/install-log.txt

#Change Directory - Home
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Switching To Home Directory..." >> ~/install-log.txt
cd ~ || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Switching To Home Directory" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Switched To Home Directory" >> ~/install-log.txt

#Script Permission Update
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Updating Script Permissions..." >> ~/install-log.txt
chmod +x ~/temp/dotfiles/custom/script/* || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Updating Script Permissions" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Script Permissions Updated" >> ~/install-log.txt

#Executing Script
echo "$(date '+%A %d %B %Y | %I:%M %p'): Message: Starting Installation Script Execution..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Executing Script ****..." >> ~/install-log.txt
~/temp/dotfiles/custom/script/*****.sh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Executing Script ****..." >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Executed Script ****..." >> ~/install-log.txt

#Change Shell - ZSH
echo "$(date '+%A %d %B %Y | %I:%M %p'): Action: Changing Shell..." >> ~/install-log.txt
chsh -s /bin/zsh || { echo "$(date '+%A %d %B %Y | %I:%M %p'): Error: Failed Changing Shell" >> ~/install-log.txt; exit 1; }
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Shell Changed" >> ~/install-log.txt

#Installation Completed
echo "$(date '+%A %d %B %Y | %I:%M %p'): Success: Installation Complete. Restart Now. Run Post Installation Scripts" >> ~/install-log.txt
echo "Installation Complete. Restart Now"