#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install gcc cmake ninja-build gettext unzip curl build-essential -y

# if neovim directory doesn't already exist,
# download neovim from source, make, and install
if [ ! -d neovim ] ; then
	echo ""
	echo "Installing neovim..."
	echo ""
	git clone https://github.com/neovim/neovim
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo -j
	sudo make install
fi

if [ -d neovim ] ; then
	echo ""
	echo "A neovim directory already exists here... OK => using it instead of downloading fresh from github"
	echo ""
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo -j
	sudo make install
fi

# if nvim config directory doesn't already exist,
# install kickstart by downloading config files from github
if [ -d "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim ] ; then
	echo ""
	echo "You already have a nvim directory in your .config directory!"
	echo -e "\tpath: ${XDG_CONFIG_HOME:-$HOME/.config/}nvim"
	
	echo ""
	echo "If you want to configure nvim with kickstart, the nvim configuration directory must not already exist"
	echo -e "\tIf your nvim config has meaningful instructions, copy it somewhere else to stash it, delete the directory, and rerun this script"
	echo -e "\tIf your nvim config does not have meaningful instructions, just delete the directory and rerun this script"
fi

if [ ! -d "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim ] ; then
	echo ""
	echo "Installing kickstart..."
	echo ""
	sudo apt install ripgrep
	git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
	echo ""
	echo "Installation successfully completed."
	echo "Start neovim by typing 'nvim'"
fi
