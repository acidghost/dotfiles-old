#!/usr/bin/env bash

echo 'Installing some apt packages...'
sudo apt install curl python-pygments

if test -e ~/antigen.zsh; then
    echo 'Antigen is already installed'
else
    echo 'Installing Antigen...'
    curl -L git.io/antigen > ~/antigen.zsh
fi

if test -e ~/.vim/autoload/plug.vim; then
    echo 'Plug is already installed'
else
    echo 'Installing Plug...'
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
