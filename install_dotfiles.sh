#!/usr/bin/env bash

set -e

binary_exists() {
    hash $1 > /dev/null 2>&1
}

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

if binary_exists stack; then
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

if binary_exists rustup; then
    echo 'rustup is already installed...'
else
    echo 'Installing rustup...'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
fi

if binary_exists rls; then
    echo 'Rust Language Server (RLS) is already installed'
else
    echo 'Installing Rust Language Server (RLS)...'
    rustup update
    rustup component add rls rust-analysis rust-src
fi

echo 'Installing xmonad + urxvt...'
sudo apt install xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev \
    suckless-tools rxvt-unicode feh xscreensaver

if [[ ! -e /usr/share/xsessions/xmonad-custom.desktop ]]; then
    sudo cp ~/xmonad-custom.desktop /usr/share/xsessions/xmonad-custom.desktop
fi

if binary_exists xmobar; then
    echo 'xmobar is already installed...'
else
    echo 'Installing xmobar...'
    sudo apt install libasound2-dev libiw-dev libxpm-dev
    git clone git://github.com/jaor/xmobar
    stack install --flag xmobar:all_extensions
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

echo 'Installing common utilities...'
sudo apt install vifm sxiv mupdf figlet toilet

echo 'Install additional FIGlet fonts...'
curl http://www.jave.de/figlet/figletfonts40.zip > ~/figletfonts.zip
unzip ~/figletfonts.zip -d ~/figletfonts
sudo mv -n ~/figletfonts/fonts/* /usr/share/figlet/
rm -rf ~/figletfonts ~/figletfonts.zip

