#!/usr/bin/env bash

PATHS=(
    ".bashrc"
    ".inputrc"
    ".tmux.conf"
    ".gitconfig"
    ".clang-format"
    ".config/nvim"
)

rm -rf "files"
mkdir files

for i in "${PATHS[@]}"
do
    cp -r "$HOME/$i" "files"
done
