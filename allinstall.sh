#!/usr/bin/env bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel git make wget
git clone https://github.com/arata-nvm/dotfiles
cd dotfiles
make allinstall
