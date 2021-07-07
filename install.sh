#!/usr/bin/env bash

sudo pacman -Syu
sudo pacman -S git make
git clone https://github.com/arata-nvm/dotfiles
cd dotfiles
make
