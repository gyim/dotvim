#!/bin/bash

set -e

if [[ ! -f vimrc ]]; then
	echo "Run this script from the .vim directory!"
	exit 1
fi

git submodule update --init
vim -c PluginInstall -c qa
ln -fs $PWD/tmux.conf ~/.tmux.conf

