#!/bin/bash
set -e

# update system
sudo pacman -Syu --noconfirm

# base packages
sudo pacman -S --needed --noconfirm git base-devel curl dnsutils

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# install zsh
sudo pacman -S --noconfirm zsh
sudo chsh -s "$(which zsh)"

# fonts
sudo pacman -S --noconfirm ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-liberation noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# hypr
sudo pacman -S --noconfirm hyprlock hyprshot

#xdg-desktop
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-utils

# applications
sudo pacman -S --noconfirm firefox chromium btop steam gnome-calculator obs-studio mpv nvim viewnior thunar

# decorative
sudo pacman -S --noconfirm cava fastfetch swww imagemagick
yay -S --noconfirm peaclock eww pipes.sh waybar-cava

# utils
sudo pacman -S --noconfirm brightnessctl clang gcc gdb cliphist flatpak gamemode lib32-gamemode pamixer os-prober gnome-keyring

# nvidia
sudo pacman -S --noconfirm linux-headers nvidia nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings egl-wayland libva-nvidia-driver nvidia-prime

# vulkan
sudo pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader vulkan-validation-layers lib32-vulkan-validation-layers vulkan-tools
