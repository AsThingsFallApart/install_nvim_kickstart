#!/usr/bin/env bash

sudo apt update
sudo apt upgrade -y
sudo apt install gcc cmake ninja-build gettext unzip curl build-esstential

# if neovim directory doesn't already exist
# download neovim from source, make, and install
if [ ! -d /neovim ] ; then
	git clone https://github.com/neovim/neovim
	cd neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo -j
	sudo make install
fi

# install kickstart
