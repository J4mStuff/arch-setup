#!/bin/sh

# Checking if is running in Repo Folder
if [[ ! "$(basename "$(pwd)" | tr '[:upper:]' '[:lower:]')" =~ ^arch-setup$ ]]; then
    echo "Run this script from it's root dir."
    exit
fi

sudo pacman -S --noconfirm archlinux-keyring plymouth
sudo sed -i 's/^#\{0,1\}ParallelDownloads.*$/ParallelDownloads = 20/' /etc/pacman.conf
sudo pacman -S --noconfirm --needed reflector git archinstall stow
sudo reflector -a 48 -c Netherlands -f 10 > /etc/pacman.d/mirrorlist

#-------------------------------------------------------------------------
#               Grub Boot Menu
#-------------------------------------------------------------------------

# set kernel parameter for adding splash screen
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash /' /etc/default/grub

THEME_DIR="/boot/grub/themes"
THEME_NAME=CyberRe

sudo mkdir -p ${THEME_DIR}
sudo cp -r configs${THEME_DIR}* {THEME_DIR}/
sudo cp -an /etc/default/grub /etc/default/grub.bak
sudo grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
sudo echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg


#-------------------------------------------------------------------------
#               Login Display Manager
#-------------------------------------------------------------------------

sudo pacman -S greetd nwg-hello
sudo systemctl enable greetd

sudo cp -r config/etc/* /etc/


#-------------------------------------------------------------------------
#               Packages
#-------------------------------------------------------------------------

yayPackages=$(sed -E 's/ /, /gm;t' <<< cat 'pkgs/yay.txt')
yay -S ${yayPackages}

pacmanPackages=$(sed -E 's/ /, /gm;t' <<< cat 'pkgs/pacman.txt')
sudo pacman -S ${pacmanPackages}


#-------------------------------------------------------------------------
#               Configs
#-------------------------------------------------------------------------

git clone git@github.com:J4mStuff/dotfiles.git ~/dotfiles && cd ~/dotfiles && stow .
