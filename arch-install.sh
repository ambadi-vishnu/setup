#!/bin/bash

###############################################################################
#                      Arch Linux Installation Script                         #
#                                                                             #
# Target Disk   : /dev/nvme0n1 (1TB)                                          #
# Partitioning  : 100 GiB (Allocated For Arch)                                #
#   1. EFI      : 2GiB (FAT32, ESP flag)                                      #
#   2. Root     : 98GiB (ext4 for system)                                     #
#                                                                             #
# Minimal Install:                                                            #
# Base System Packages: base, linux, linux-firmware                           #
# Microcode      : intel-ucode                                                #
# Audio/Multimedia: pipewire, pipewire-alsa, pipewire-jack, pipewire-pulse,   #
#                   gst-plugin-pipewire, wireplumber, and libpulse            #
# Development/Utilities: base-devel, networkmanager, git, nano, sudo          #
#                                                                             #
# Locale      : en_IN.UTF-8                                                   #
# Timezone    : Asia/Kolkata (India) with NTP enabled                         #
# Keymap      : US                                                            #
# Repositories: [core], [extra], [multilib] Enabled; [testing] Disabled       #
#                                                                             #
# Boot Loader : GRUB                                                          #
#                                                                             #
# Root Account Disabled. New User With Root Privileges Will Be Created.       #
###############################################################################

# Exit immediately if a command returns a non-zero exit status, 
# treat unset variables as errors, and catch errors in pipelines.
set -euo pipefail

# Log file to capture output and errors.
LOG="/root/arch_install.log"
exec > >(tee -a "$LOG") 2>&1

# Unified error reporting.
function error_exit {
  echo "[ERROR] $1"
  exit 1
}

# Trap errors and display the line number of the unexpected error.
trap 'error_exit "An unexpected error occurred on line $LINENO. Please check ${LOG}."' ERR

# Ensure the script is running as root.
if [[ $EUID -ne 0 ]]; then
  error_exit "This script must be run as root."
fi

###############################
# User Input for Customization #
###############################

echo "======================================"
echo "    Arch Linux Automated Installer    "
echo "======================================"
read -rp "Enter Hostname: " HOSTNAME
read -rp "Enter UserName: " USERNAME
echo "Enter Password For User ${USERNAME}: "
read -rs PASSWORD
echo
echo "[INFO] Hostname Set: ${HOSTNAME}"
echo "[INFO] Username Set: ${USERNAME}"

###############################
# Variables & Partition Setup #
###############################
# Target drive and partition scheme.
DRIVE="/dev/nvme0n1"
EFI_SIZE="2GiB"         # EFI partition.
INSTALL_END="100GiB"       # Total allocated installation space (EFI + root).

# Define partition names.
EFI_PARTITION="${DRIVE}p1"
ROOT_PARTITION="${DRIVE}p2"
MOUNT_POINT="/mnt"

# Confirm target drive exists.
if [ ! -b "$DRIVE" ]; then
  error_exit "Drive $DRIVE does not exist."
fi

####################################################
# Wipe Existing Disk Data (THIS WILL ERASE ALL!)   #
####################################################
echo "Wiping existing partition tables and signatures on ${DRIVE}..."
sgdisk --zap-all "${DRIVE}" || error_exit "Failed wiping existing partitions on $DRIVE."
wipefs -a "${DRIVE}" || error_exit "Failed wiping existing file system on $DRIVE."
echo "Disk wipe complete."

#################################
# Partitioning Using parted     #
#################################
echo "[INFO] Partitioning drive $DRIVE with GPT."

# Create a new GPT partition table.
parted -s "$DRIVE" mklabel gpt || error_exit "Failed to create GPT partition table on $DRIVE."

# Create the EFI partition from 1MiB to EFI_SIZE (2GiB).
parted -s "$DRIVE" mkpart ESP fat32 1MiB ${EFI_SIZE} || error_exit "Failed to create EFI partition."
# Set the EFI system flag.
parted -s "$DRIVE" set 1 esp on || error_exit "Failed to set EFI boot flag."

# Create root partition from EFI_SIZE to INSTALL_END (2GiB to 100GB).
parted -s "$DRIVE" mkpart primary ext4 ${EFI_SIZE} ${INSTALL_END} || error_exit "Failed to create root partition."

echo "[INFO] Partitioning complete."

###############################
# Formatting Partitions       #
###############################
echo "[INFO] Formatting partitions."

# Format the EFI partition as FAT32.
mkfs.fat -F32 "$EFI_PARTITION" || error_exit "Failed to format EFI partition."

# Format the root partition as ext4.
mkfs.ext4 "$ROOT_PARTITION" || error_exit "Failed to format root partition."

echo "[INFO] Partition formatting complete."

###############################
# Mounting Partitions         #
###############################
echo "[INFO] Mounting partitions."

mount "$ROOT_PARTITION" "$MOUNT_POINT" || error_exit "Failed to mount root partition."
mkdir -p "$MOUNT_POINT/boot"
mount "$EFI_PARTITION" "$MOUNT_POINT/boot" || error_exit "Failed to mount EFI partition."

echo "[INFO] Partitions mounted."

##################################
# Installing the Base System     #
##################################
echo "[INFO] Installing base system and additional packages."

# Install the base system and additional packages.
pacstrap "$MOUNT_POINT" base linux linux-firmware intel-ucode pipewire networkmanager git nano base-devel sudo pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber || error_exit "Pacstrap installation failed."

echo "[INFO] Base system installation complete."

# Generate fstab file using UUIDs.
echo "[INFO] Generating fstab."
genfstab -U "$MOUNT_POINT" >> "$MOUNT_POINT/etc/fstab" || error_exit "Failed to generate fstab."

###########################################
# System Configuration in chroot          #
###########################################
echo "[INFO] Entering chroot for system configuration."

arch-chroot "$MOUNT_POINT" /bin/bash <<EOF
set -euo pipefail

echo "[CHROOT] Configuring system settings..."

# --- Locale Configuration ---
echo "en_IN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen || { echo "[CHROOT ERROR] Locale generation failed"; exit 1; }

# --- Keyboard layout ---
echo "KEYMAP=us" > /etc/vconsole.conf

# --- Timezone and NTP ---
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
timedatectl set-ntp true

# --- Hostname & Hosts ---
echo "${HOSTNAME}" > /etc/hostname
cat <<HOSTS_EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${HOSTNAME}.localdomain ${HOSTNAME}
HOSTS_EOF

# --- Enable the Multilib Repository ---
# Uncomment the [multilib] section in /etc/pacman.conf.
sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf

# Update package databases.
pacman -Syyu --noconfirm || { echo "[CHROOT ERROR] Failed to update package databases"; exit 1; }

# --- Create non-root user and configure sudo ---
useradd -m -G wheel ${USERNAME} || { echo "[CHROOT ERROR] Failed to create user ${USERNAME}"; exit 1; }
echo "${USERNAME}:${PASSWORD}" | chpasswd || { echo "[CHROOT ERROR] Failed to set password for ${USERNAME}"; exit 1; }
echo "${USERNAME} ALL=(ALL) ALL" > /etc/sudoers.d/99_${USERNAME}
chmod 440 /etc/sudoers.d/99_${USERNAME}

# --- Enable Services ---
systemctl enable NetworkManager || { echo "[CHROOT ERROR] Failed to enable NetworkManager"; exit 1; }
systemctl enable pipewire pipewire-pulse wireplumber || { echo "[CHROOT ERROR] Failed to enable pipewire"; exit 1; }

# --- Bootloader: Install GRUB for EFI ---
pacman -S --noconfirm grub efibootmgr || { echo "[CHROOT ERROR] Failed to install GRUB or efibootmgr"; exit 1; }
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB || { echo "[CHROOT ERROR] GRUB installation failed"; exit 1; }
grub-mkconfig -o /boot/grub/grub.cfg

echo "[CHROOT] System configuration complete."
EOF

echo "[INFO] Exiting chroot."

##############################
# Unmounting and Finalizing  #
##############################
echo "[INFO] Unmounting partitions."
umount -R "$MOUNT_POINT" || error_exit "Failed to unmount partitions."

echo "[INFO] Arch Linux installation complete. You may now reboot your system."
