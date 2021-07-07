#!/usr/bin/env bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git make
git clone https://github.com/arata-nvm/dotfiles
cd dotfiles
make
