.PHONY: allinstall

PWD=$(cd $(dirname $0); pwd -P)

allinstall: install gnome fish git tmux vim ssh gpg fcitx code docker

install:
	sudo pacman-mirrors --fasttrack
	sudo pacman -Syu
	sudo pacman -S base-devel chromium p7zip trash-cli yay bat clang gdb ffmpeg ltrace strace nasm vagrant virtualbox discord
	yay -S slack-desktop

gnome:
	dconf load / < ${PWD}/gnome/gnome.dconf

fish:
	sudo pacman -S fish
	chsh -s /bin/bash user01
	echo "fish" >> ~/.bashrc
	mkdir -p ${HOME}/.config/fish/functions
	ln -svf ${PWD}/home/.config/fish/config.fish ${HOME}/.config/fish/config.fish
	ln -svf ${PWD}/home/.config/fish/fish_variables ${HOME}/.config/fish/fish_variables
	ln -svf ${PWD}/home/.config/fish/functions/fish_prompt.fish ${HOME}/.config/fish/functions/fish_prompt.fish

git:
	sudo pacman -S git-crypt github-cli
	yay -S ghq-bin git-delta-bin
	ln -svf ${PWD}/home/.gitconfig ${HOME}/.gitconfig
	ln -svf ${PWD}/home/.gitignore_global ${HOME}/.gitignore_global
	ln -svf ${PWD}/home/.gitmessage ${HOME}/.gitmessage

tmux:
	sudo pacman -S tmux
	ln -svf ${PWD}/home/.tmux.conf ${HOME}/.tmux.conf

vim:
	sudo pacman -S neovim nodejs python-pynvim
	ln -svf ${PWD}/home/.vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.config/nvim
	ln -svf ${PWD}/home/.vimrc ${HOME}/.config/nvim/init.vim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	echo "EDITOR=/usr/bin/nvim" >> ~/.bash_profile

ssh:
	mkdir -p ${HOME}/.ssh
	ln -svf ${PWD}/home/.ssh/id_rsa ${HOME}/.ssh/id_rsa 
	chmod 0600 ${HOME}/.ssh/id_rsa
	ln -svf ${PWD}/home/.ssh/id_rsa.pub ${HOME}/.ssh/id_rsa.pub 
	ssh-add ${HOME}/.ssh/id_rsa

gpg:
	gpg --import ${PWD}/gpg/public_key.gpg
	gpg --import ${PWD}/gpg/private_key.gpg
	gpg --import-ownertrust ${PWD}/gpg/ownertrust.txt

fcitx:
	sudo pacman -S fcitx5-im fcitx5-mozc
	ln -svf ${PWD}/home/.pam_environment ${HOME}/.pam_environment
	# TODO fcitx settings

code:
	yay -S visual-studio-code-bin
	ln -svf ${PWD}/home/.config/Code/User/settings.json ${HOME}/.config/Code/User/settings.json

docker:
	sudo pacman -S docker docker-compose
	sudo groupadd docker
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker
	sudo systemctl start docker
