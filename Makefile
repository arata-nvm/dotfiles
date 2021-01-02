.PHONY: allinstall update
.DEFAULT_GOAL := update
 
update:
	git add . -p
	git status
	git commit -m ":sparkles: update"
	git push

allinstall: install gnome fish git tmux vim ssh gpg fcitx code docker ctf

install:
	sudo pacman-mirrors --fasttrack
	sudo pacman -Syu
	sudo pacman -S base-devel chromium p7zip trash-cli yay bat clang gdb ffmpeg ltrace strace nasm vagrant virtualbox discord
	yay -S slack-desktop

gnome:
	dconf load / < ${CURDIR}/gnome/gnome.dconf

fish:
	sudo pacman -S fish
	chsh -s /bin/bash user01
	echo "fish" >> ~/.bashrc
	mkdir -p ${HOME}/.config/fish/functions
	ln -svf ${CURDIR}/home/.config/fish/config.fish ${HOME}/.config/fish/config.fish
	ln -svf ${CURDIR}/home/.config/fish/fish_variables ${HOME}/.config/fish/fish_variables
	ln -svf ${CURDIR}/home/.config/fish/functions/fish_prompt.fish ${HOME}/.config/fish/functions/fish_prompt.fish

git:
	sudo pacman -S git-crypt github-cli tig
	yay -S ghq-bin git-delta-bin
	ln -svf ${CURDIR}/home/.gitconfig ${HOME}/.gitconfig
	ln -svf ${CURDIR}/home/.gitignore_global ${HOME}/.gitignore_global
	ln -svf ${CURDIR}/home/.gitmessage ${HOME}/.gitmessage

tmux:
	sudo pacman -S tmux
	ln -svf ${CURDIR}/home/.tmux.conf ${HOME}/.tmux.conf

vim:
	sudo pacman -S neovim nodejs python-pynvim
	ln -svf ${CURDIR}/home/.vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.config/nvim
	ln -svf ${CURDIR}/home/.vimrc ${HOME}/.config/nvim/init.vim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo "EDITOR=/usr/bin/nvim" >> ~/.bash_profile

ssh:
	mkdir -p ${HOME}/.ssh
	ln -svf ${CURDIR}/home/.ssh/id_rsa ${HOME}/.ssh/id_rsa 
	chmod 0600 ${HOME}/.ssh/id_rsa
	ln -svf ${CURDIR}/home/.ssh/id_rsa.pub ${HOME}/.ssh/id_rsa.pub 
	ssh-add ${HOME}/.ssh/id_rsa

gpg:
	gpg --import ${CURDIR}/gpg/public_key.gpg
	gpg --import ${CURDIR}/gpg/private_key.gpg
	gpg --import-ownertrust ${CURDIR}/gpg/ownertrust.txt

fcitx:
	sudo pacman -S fcitx5-im fcitx5-mozc
	ln -svf ${CURDIR}/home/.pam_environment ${HOME}/.pam_environment
	# TODO fcitx settings

code:
	yay -S visual-studio-code-bin
	ln -svf ${CURDIR}/home/.config/Code/User/settings.json ${HOME}/.config/Code/User/settings.json

docker:
	sudo pacman -S docker docker-compose
	sudo groupadd docker
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker
	sudo systemctl start docker

ctf:
	sudo pacman -S radare2-cutter r2ghidra-dec