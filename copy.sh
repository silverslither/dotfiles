#!/usr/bin/env bash

PATHS=(
    "$HOME/.zshrc"
    "$HOME/.inputrc"
    "$HOME/.tmux.conf"
    "$HOME/.gitconfig"
    "$HOME/.clang-format"
    "$HOME/.config/mimeapps.list"
    "$HOME/.config/nvim"
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/dunst/dunstrc"
    "$HOME/.config/foot"
    "$HOME/.config/bottom/bottom.toml"
    "$HOME/.config/mpv/mpv.conf"
    "/boot/sbsign-grub-install.sh"
    "/boot/shim-nvram.sh"
    "/usr/share/X11/xkb/symbols/custom"
    "/etc/greetd"
)

rm -rf "files"
mkdir files

for i in "${PATHS[@]}"
do
    cp -r "$i" "files"
done
