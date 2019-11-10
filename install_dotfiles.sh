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

if [[ -d /opt/base16-xresources ]]; then
    echo 'base16-xresources is already installed'
else
    echo 'Installing base16-xresources...'
    sudo git clone https://github.com/binaryplease/base16-xresources.git \
        /opt/base16-xresources
fi

if [[ which stack 2>&1 /dev/null ]]; then
    echo "Haskell stack is installed"
else
    echo "Installing Haskell's stack..."
    curl -sSL https://get.haskellstack.org/ | sh
fi

if [[ -e ~/.local/bin/hie-wrapper ]]; then
    echo 'Haskell IDE Engine already installed'
else
    echo 'Installing Haskell IDE Engine...'
    git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
    cd haskell-ide-engine
    stack ./install.hs stack-hie-8.6.5
    cd $HOME
fi

echo 'Installing xmonad + urxvt...'
sudo apt install xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev \
    suckless-tools xmobar rxvt-unicode feh

if [[ ! -e /usr/share/xsessions/xmonad-custom.desktop ]]; then
    sudo cp ~/xmonad-custom.desktop /usr/share/xsessions/xmonad-custom.desktop
fi

if [[ -d /opt/lux ]]; then
    echo 'lux is installed'
else
    sudo git clone https://github.com/Ventto/lux.git /opt/lux
    cd /opt/lux
    sudo make install
    sudo lux -S 100%
    cd $HOME
fi

