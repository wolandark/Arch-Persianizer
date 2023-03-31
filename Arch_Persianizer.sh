#!/usr/bin/env bash

# Written By Woland

# Persian language and localization

#Dependency:
#          base-devel
#          git

# https://github.com/wolandark
# https://github.com/wolandark/Arch-Persianizer

packages=(
  base-devel
  noto-fonts
  git
  ttf-liberation
)
sudo pacman -Sy "${packages[@]}" --noconfirm

aur_packages=(
  https://aur.archlinux.org/iranian-fonts.git
  https://aur.archlinux.org/xkb-switch.git
  https://aur.archlinux.org/bicon-git.git
)
for pkg in "${aur_packages[@]}"; do
  git clone "$pkg"
done

directories=(
  iranian-fonts
  xkb-switch
  bicon-git
)

for dir in "${directories[@]}"; do
  cd "$dir" || { echo "Error: could not change to directory $dir"; exit 1; }
  makepkg -sri || { echo "Error: failed to install packages in directory $dir"; exit 1; }
  cd || return
done

sudo sed -i '/^#.*fa_IR\ UTF-8/s/^#//' /etc/locale.gen
sudo locale-gen
sudo timedatectl set-timezone Asia/Tehran

sudo sh -c 'echo "Section \"InputClass\"
        Identifier \"system-keyboard\"
        MatchIsKeyboard \"on\"
        Option \"XkbLayout\" \"us,ir\"
EndSection" > /etc/X11/xorg.conf.d/00-keyboard.conf'

#bicon
echo -e "برای تغییر زبان از د ستور زیر استفاده کنید"
echo -e "Use this command to change keyboard layout"
echo -e "\n\033[7;32mxkb-switch -n\033[0m"
بسته به د سکتاپ یا ویندو منیجر خود می توانید این د ستور را به یک شورتکات  ا ختصا ص دهید"

echo "If you dont see the above msg properly, Change your terminal font to Liberation"

echo "Checking ..."

installed=$(echo -e "\033[7;32mInstalled\033[0m")

report=(
    "Iranian Fonts"
    "Xkb-Switch"
    "Bicon"
    "Base-Devel"
    "Noto Fonts"
    "Git"
)

for i in "${report[@]}"; do
    printf "%-25s %b\n" "${i//[- ]/_}" "$installed"
done

printf "%-25s \033[7;32mGenerated\033[0m\n" "Farsi Locale"
printf "%-25s \033[7;32mSet\033[0m\n" "Iran Time"
printf "%-25s \033[7;32mAdded to Xorg Configurations\033[0m\n" "Farsi Keyboard Layout"

exit 0
