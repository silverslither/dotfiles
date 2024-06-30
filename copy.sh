#!/usr/bin/env bash

PATHS=(
    "$HOME/.bashrc"
    "$HOME/.inputrc"
    "$HOME/.colemak.inputrc"
    "$HOME/.tmux.conf"
    "$HOME/.gitconfig"
    "$HOME/.clang-format"
    "$HOME/.config/nvim"
    "/boot/sbsign-grub-install.sh"
    "/boot/shim-nvram.sh"
)

rm -rf "files"
mkdir files

for i in "${PATHS[@]}"
do
    cp -r "$i" "files"
done
