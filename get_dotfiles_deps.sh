#!/usr/bin/env bash

set -e

echo 'Installing some apt packages...'
sudo apt install curl python3-pip python-pygments

# Install Antigen (zsh plugin manager)
if [[ -e ~/antigen.zsh ]]; then
    echo 'Antigen is already installed'
else
    echo 'Installing Antigen...'
    curl -L git.io/antigen > ~/antigen.zsh
fi

# Install Plug (Vim plugin manager)
if [[ -e ~/.vim/autoload/plug.vim ]]; then
    echo 'Plug is already installed'
else
    echo 'Installing Plug...'
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install Python language server + YAPF & PyFlakes
pip3 install python-language-server \
    'python-language-server[yapf]' \
    'python-language-server[pyflakes]'

if [[ -d /opt/neofetch ]]; then
    echo 'neofetch is already installed'
else
    echo 'Installing neofetch...'
    cd /opt
    sudo git clone https://github.com/dylanaraps/neofetch.git
    cd neofetch
    sudo git checkout 6.1.0
    sudo make install
    cd $HOME
fi

