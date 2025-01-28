#!/usr/bin/env bash

PATHS=(
    "$HOME/.zshrc"
    "$HOME/.gitconfig"
    "$HOME/.clang-format"
    "$HOME/.config/mimeapps.list"
    "$HOME/.config/nvim"
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/dunst"
    "$HOME/.config/foot"
    "$HOME/.config/bottom"
    "$HOME/.config/mpv"
    "$HOME/.config/swayimg"
    "$HOME/.config/tofi"
    "/usr/local/bin/sbsign-grub-install"
    "/usr/local/bin/shim-nvram"
    "/usr/share/X11/xkb/symbols/custom"
    "/etc/greetd"
    "/etc/udev/rules.d/90-charging.rules"
)

rm -rf "files"
mkdir files

for i in "${PATHS[@]}"
do
    cp -r "$i" "files"
done
