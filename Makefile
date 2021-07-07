PACMAN := sudo pacman -S --noconfirm
YAY := yay -S --noconfirm
SYSTEMD := sudo systemctl enable

define link
	mkdir -p $(shell dirname $(HOME)/$(1))
	ln -svf $(CURDIR)/home/$(1) $(HOME)/$(1)
endef

.DEFAULT_GOAL := update
 
.PHONY: update
update:
	git add . -p
	git status
	git commit -m ":sparkles: update"
	git push

.PHONY: allinstall
allinstall: pacman yay secrets font gnome fish git tmux vim fcitx code mpv ctf alacritty i3

.PHONY: wslinstall
wslinstall: fish git tmux vim
	sudo pacman -Syu
	$(PACMAN) base-devel

.PHONY: pacman
pacman:
	sudo reflector --verbose --country 'Japan' --protocol https --sort rate --save /etc/pacman.d/mirrorlist
	sudo pacman -Syu
	$(PACMAN) base-devel p7zip trash-cli bat clang gdb ffmpeg ltrace strace nasm vagrant virtualbox discord firefox-developer-edition youtube-dl fd ripgrep hexyl exa hyperfine sd wget openssh

.PHONY: yay
yay:
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay && makepkg -si --noconfirm
	$(YAY) slack-desktop bvi google-chrome

.PHONY: secrets
secrets:
	wget https://github.com/dropbox/dbxcli/releases/download/v3.0.0/dbxcli-linux-amd64 -O /tmp/dbxcli
	chmod +x /tmp/dbxcli
	
	# ssh
	/tmp/dbxcli get /Linux/.ssh/id_rsa $(HOME)/.ssh/id_rsa
	/tmp/dbxcli get /Linux/.ssh/id_rsa.pub $(HOME)/.ssh/id_rsa.pub
	chmod 600 $(HOME)/.ssh/id_rsa
	chmod 600 $(HOME)/.ssh/id_rsa.pub
	
	# gpg
	/tmp/dbxcli get /Linux/gpg/private_key.gpg /tmp/private_key.gpg
	/tmp/dbxcli get /Linux/gpg/public_key.gpg /tmp/public_key.gpg
	/tmp/dbxcli get /Linux/gpg/ownertrust.txt /tmp/ownertrust.txt
	gpg --import /tmp/private_key.gpg
	gpg --import /tmp/public_key.gpg
	gpg --import-ownertrust /tmp/ownertrust.txt
	rm -f /tmp/private_key.gpg /tmp/public_key.gpg /tmp/ownertrust.txt

.PHONY: font
font:
	$(PACMAN) noto-fonts-emoji
	sudo ln -svf $(CURDIR)/etc/fonts/local.conf /etc/fonts/local.conf

.PHONY: gnome
gnome:
	$(PACMAN) evince gdm gnome-backgrounds gnome-control-center gnome-keyring gnome-terminal gnome-tweaks nautilus sushi gnome-shell-extension-appindicator libappindicator-gtk3
	$(YAY) xcursor-breeze papirus-maia-icon-theme-git gnome-shell-extension-pop-shell-bin
	$(SYSTEMD) gdm.service
	dconf load / < $(CURDIR)/gnome/gnome.dconf

.PHONY: fish
fish:
	$(PACMAN) fish
	sudo chsh -s /bin/bash $(USER)
	echo "fish" >> ~/.bashrc
	$(call link,.config/fish/config.fish)
	$(call link,.config/fish/fish_variables)
	$(call link,.config/fish/functions/fish_prompt.fish)

.PHONY: git
git:
	$(PACMAN) git-crypt github-cli tig
	$(YAY) ghq-bin git-delta-bin
	$(call link,.gitconfig)
	$(call link,.gitignore_global)
	$(call link,.gitmessage)

.PHONY: tmux
tmux:
	$(PACMAN) tmux
	$(call link,.tmux.conf)

.PHONY: vim
vim:
	$(PACMAN) neovim nodejs python-pynvim
	$(call link,.vimrc)
	mkdir -p $(HOME)/.config/nvim
	ln -svf $(CURDIR)/home/.vimrc $(HOME)/.config/nvim/init.vim
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-$$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo "EDITOR=/usr/bin/nvim" >> ~/.bash_profile

.PHONY: fcitx
fcitx:
	$(PACMAN) fcitx5-im fcitx5-mozc
	$(call link,.pam_environment)
	# TODO fcitx settings

.PHONY: code
code:
	$(YAY) visual-studio-code-bin

.PHONY: docker
docker:
	$(PACMAN) docker docker-compose
	sudo usermod -aG docker $(USER)
	sudo systemctl enable docker
	sudo systemctl start docker

.PHONY: mpv
mpv:
	$(PACMAN) mpv
	$(call link,.config/mpv/input.conf)
	$(call link,.config/mpv/mpv.conf)
	$(call link,.config/mpv/scripts/ontop-playback.lua)

.PHONY: ctf
ctf:
	$(PACMAN) iaito r2ghidra

.PHONY: alacritty
alacritty:
	$(PACMAN) alacritty
	$(call link,.config/alacritty/alacritty.yml)

.PHONY: i3
i3:
	$(PACMAN) i3
	$(call link,.config/i3/config)
