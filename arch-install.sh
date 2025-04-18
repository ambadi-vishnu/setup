#!/bin/bash
set -e

###############################################################################
# Arch Linux UEFI GPT Installation Script with User Creation and Prompts      #
# and PipeWire Installation/Configuration                                     #
#                                                                             #
# Target Disk   : /dev/nvme0n1 (1TB)                                          #
# Partitioning  :                                                             #
#   1. EFI      : 2GB (FAT32, ESP flag)                                       #
#   2. Root     : 48GB (ext4 for system)                                      #
#   3. Home     : 50GB (ext4 for /home)                                       #
#   4. Shared   : 700GB (NTFS, label "Shared")                                #
#                                                                             #
# Minimal install:                                                            #
#   Packages: base, linux, linux-firmware, intel-ucode, git, nano,            #
#             networkmanager, ntfs-3g,                                        #
#             pipewire, pipewire-alsa, pipewire-pulse, pipewire-jack,         #
#             wireplumber                                                     #
#                                                                             #
# Locale      : en_US.UTF-8                                                   #
# Timezone    : Asia/Kolkata (India) with NTP enabled                         #
# Repositories: [core], [extra], [multilib] enabled; [testing] disabled       #
#                                                                             #
# Instead of enabling the root account, you will create a user with root      #
# privileges.                                                                 #
###############################################################################

# Define disk and partition sizes:
DISK="/dev/nvme0n1"
EFI_SIZE="2GiB"
ROOT_START="2GiB"
ROOT_END="50GiB"       # Root uses 48GiB (from 2GiB to 50GiB)
HOME_START="50GiB"
HOME_END="100GiB"      # Home uses 50GiB (from 50GiB to 100GiB)
SHARED_START="100GiB"
SHARED_END="800GiB"    # Shared partition uses 700GiB

# Partition device names (for NVMe devices, partitions use the 'p' separator):
EFI_PART="${DISK}p1"
ROOT_PART="${DISK}p2"
HOME_PART="${DISK}p3"
SHARED_PART="${DISK}p4"

echo "============================================"
echo "  Starting Arch Linux Installation Process  "
echo "  Target Disk: ${DISK}"
echo "============================================"
sleep 2

####################################################
# 1. Wipe Existing Disk Data (THIS WILL ERASE ALL!) #
####################################################
echo "[1/9] WARNING: This will completely wipe all data on ${DISK}!"
sleep 2
echo "Wiping existing partition tables and signatures on ${DISK}..."
sgdisk --zap-all "${DISK}"
wipefs -a "${DISK}"
echo "Disk wipe complete."
sleep 2

##############################
# 2. Partitioning the Disk   #
##############################
echo "[2/9] Creating a new GPT partition table on ${DISK}..."
parted --script "${DISK}" mklabel gpt

echo "Creating EFI partition (${EFI_SIZE})..."
parted --script "${DISK}" \
  mkpart primary fat32 1MiB ${EFI_SIZE} \
  set 1 esp on

echo "Creating Root partition (from ${ROOT_START} to ${ROOT_END})..."
parted --script "${DISK}" \
  mkpart primary ext4 ${ROOT_START} ${ROOT_END}

echo "Creating Home partition (from ${HOME_START} to ${HOME_END})..."
parted --script "${DISK}" \
  mkpart primary ext4 ${HOME_START} ${HOME_END}

echo "Creating Shared partition (NTFS, from ${SHARED_START} to ${SHARED_END})..."
parted --script "${DISK}" \
  mkpart primary ntfs ${SHARED_START} ${SHARED_END}

echo "Partition table after changes:"
lsblk "${DISK}"
sleep 3

##############################
# 3. Formatting Partitions   #
##############################
echo "[3/9] Formatting partitions..."

echo "Formatting EFI partition (${EFI_PART}) as FAT32..."
mkfs.fat -F32 "${EFI_PART}"

echo "Formatting Root partition (${ROOT_PART}) as ext4..."
mkfs.ext4 -F -L ArchRoot "${ROOT_PART}"

echo "Formatting Home partition (${HOME_PART}) as ext4..."
mkfs.ext4 -F -L ArchHome "${HOME_PART}"

echo "Formatting Shared partition (${SHARED_PART}) as NTFS..."
mkfs.ntfs -f -L Shared "${SHARED_PART}"

##############################
# 4. Mounting Partitions     #
##############################
echo "[4/9] Mounting partitions..."

# Mount root partition:
mount "${ROOT_PART}" /mnt

# Create mount points and mount EFI & Home partitions:
mkdir -p /mnt/boot/efi
mount "${EFI_PART}" /mnt/boot/efi

mkdir -p /mnt/home
mount "${HOME_PART}" /mnt/home

# Optionally mount the shared partition:
mkdir -p /mnt/shared
mount -t ntfs-3g "${SHARED_PART}" /mnt/shared || echo "Warning: Could not mount shared partition now. You may mount it later."

##############################
# 5. Base System Installation#
##############################
echo "[5/9] Installing base system and essential packages..."
pacstrap /mnt base linux linux-firmware intel-ucode git nano networkmanager ntfs-3g \
         pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber

##############################
# 6. Generate fstab          #
##############################
echo "[6/9] Generating fstab file..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "Generated /mnt/etc/fstab:"
cat /mnt/etc/fstab
sleep 2

#####################################################
# 7. Get Hostname, Username, and Password from User #
#####################################################
echo "[7/9] Configuration: Please provide additional information."
read -rp "Enter hostname for the new system: " HOSTNAME_INPUT
read -rp "Enter username for the primary non-root user (with root privileges): " USERNAME_INPUT
read -srp "Enter password for the user: " USERPASS_INPUT
echo ""
echo "You entered hostname: $HOSTNAME_INPUT and username: $USERNAME_INPUT."

#########################################################################
# 8. Chroot and Post-install Configuration (with non-root user creation) #
#########################################################################
echo "[8/9] Entering arch-chroot to configure the system..."

# Create a temporary chroot configuration script with variable expansion:
cat <<EOF > /mnt/root/chroot_setup.sh
#!/bin/bash
set -e

echo "-----------------------------"
echo "  Configuring Timezone & NTP  "
echo "-----------------------------"
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
timedatectl set-ntp true

echo "-----------------------------"
echo "  Generating locales        "
echo "-----------------------------"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "-----------------------------"
echo "  Setting hostname          "
echo "-----------------------------"
echo "$HOSTNAME_INPUT" > /etc/hostname
cat <<HOSTS_EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   ${HOSTNAME_INPUT}.localdomain ${HOSTNAME_INPUT}
HOSTS_EOF

echo "-----------------------------"
echo "  Updating pacman.conf      "
echo "-----------------------------"
# Enable [multilib] and ensure [testing] remains disabled.
sed -i '/^

\[multilib\]

/,/^Include/ s/^#//' /etc/pacman.conf
sed -i '/^

\[testing\]

/,/^Include/ s/^/#/' /etc/pacman.conf

echo "-----------------------------"
echo "  Enabling NetworkManager   "
echo "-----------------------------"
systemctl enable NetworkManager

echo "-----------------------------"
echo "  Configuring PipeWire       "
echo "-----------------------------"
echo "PipeWire and its related packages have been installed."
echo "By default, PipeWire is configured with its default settings."
echo "To enable PipeWire’s user services, after logging in as $USERNAME_INPUT, run:"
echo "    systemctl --user enable pipewire pipewire-pulse wireplumber"
echo "and then"
echo "    systemctl --user start pipewire pipewire-pulse wireplumber"

echo "-----------------------------"
echo "  Installing GRUB Bootloader (UEFI)  "
echo "-----------------------------"
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo "-----------------------------"
echo "  Creating primary non-root user "
echo "-----------------------------"
useradd -m -G wheel -s /bin/bash "$USERNAME_INPUT"
echo "$USERNAME_INPUT:$USERPASS_INPUT" | chpasswd
# Lock the root account to disable direct root logins:
passwd -l root

echo "-----------------------------"
echo "  Enabling sudo privileges for wheel group "
echo "-----------------------------"
sed -i '/^# %wheel ALL=(ALL) ALL/s/^# //' /etc/sudoers

echo "-----------------------------"
echo "  Chroot setup complete!    "
echo "-----------------------------"
EOF

chmod +x /mnt/root/chroot_setup.sh
arch-chroot /mnt /bin/bash /root/chroot_setup.sh
rm /mnt/root/chroot_setup.sh

echo "============================================"
echo "   Installation is complete!              "
echo "   Please unmount and reboot your system.   "
echo "============================================"
echo "After exiting the chroot, run:"
echo "  umount -R /mnt"
echo "  reboot"
