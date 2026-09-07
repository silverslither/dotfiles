#!/usr/bin/env bash

PATHS=(
    "$HOME/.zshrc"
    "$HOME/.gitconfig"
    "$HOME/.clang-format"
    "$HOME/.config/mimeapps.list"
    "$HOME/.config/wireplumber"
    "$HOME/.config/nvim"
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/dunst"
    "$HOME/.config/foot"
    "$HOME/.config/bottom"
    "$HOME/.config/mpv"
    "$HOME/.config/swayimg"
    "$HOME/.config/tofi"
    "$HOME/.config/zen/*/chrome/user*.css"
    "/etc/udev/rules.d"
    "/etc/vconsole.conf"
    "/etc/sysctl.d"
    "/etc/greetd"
    "/etc/keyd"
    "/usr/share/xkeyboard-config-2/symbols/custom"
    "/usr/local/bin/set-power-profile"
    "/usr/local/bin/sbsign-grub-install"
    "/usr/local/bin/shim-nvram"
)

rm -rf "files"
mkdir files

for i in "${PATHS[@]}"
do
    cp -r $i files
done
