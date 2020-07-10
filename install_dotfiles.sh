#!/usr/bin/env bash

set -e

binary_exists() {
    hash $1 > /dev/null 2>&1
}

echo 'Installing some apt packages...'
sudo apt install curl python3-pip python-pygments python3-dev python3-setuptools

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
    stack ./install.hs stack-build-data
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

echo 'Installing xmonad deps + urxvt + feh + xscreensaver...'
sudo apt install libx11-dev libxinerama-dev libxext-dev \
    libxrandr-dev libxss-dev libxft-dev↑ \
    suckless-tools rxvt-unicode feh xscreensaver

if binary_exists xmonad; then
    echo 'xmonad is already installed...'
else
    echo 'Installing xmonad...'
    cd ~/.xmonad
    git clone "https://github.com/xmonad/xmonad"
    cd xmonad
    git checkout v0.15
    cd ..
    git clone "https://github.com/xmonad/xmonad-contrib" xmonad-contrib
    cd xmonad-contrib
    git checkout v0.16
    cd ..
    stack install
    cd $HOME
fi

if [[ ! -e /usr/share/xsessions/xmonad.desktop ]]; then
    sudo cp ~/xmonad.desktop /usr/share/xsessions/xmonad.desktop
fi

if binary_exists xmobar-top; then
    echo 'xmobar is already installed...'
else
    echo 'Installing xmobar...'
    cd .xmobar/xmobar-config
    stack install
    cd $HOME
fi

if binary_exists lux; then
    echo 'lux is installed'
else
    sudo git clone https://github.com/Ventto/lux.git /opt/lux
    cd /opt/lux
    sudo make install
    sudo lux -S 100%
    cd $HOME
fi

echo 'Installing common utilities...'
sudo apt install vifm sxiv zathura figlet toilet

echo 'Install additional FIGlet fonts...'
curl http://www.jave.de/figlet/figletfonts40.zip > ~/figletfonts.zip
unzip ~/figletfonts.zip -d ~/figletfonts
sudo mv -n ~/figletfonts/fonts/* /usr/share/figlet/
rm -rf ~/figletfonts ~/figletfonts.zip

if binary_exists dunst; then
    echo 'dunst is already installed'
else
    echo 'Installing dunst dependencies...'
    sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev \
        libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev \
        libnotify-dev
    echo 'Installing dunst...'
    sudo git clone https://github.com/dunst-project/dunst.git /opt/dunst
    cd /opt/dunst
    sudo make
    sudo make dunstify
    sudo make install
    sudo install -Dm755 dunstify /usr/local/bin/dunstify
    cd $HOME
fi

echo 'Installing resize-font extension for urxvt'
if [ -e './.urxvt/ext/resize-font' ]; then
    echo 'resuze-font is already installed'
else
    cd ./.urxvt/ext
    git clone https://github.com/simmel/urxvt-resize-font.git
    ln -s urxvt-resize-font/resize-font resize-font
    cd $HOME
fi

echo 'Installing thefuck'
pip3 install --user thefuck

echo 'Installing virtualenvwrapper'
pip3 install --user virtualenvwrapper

install_deb() {
    local dest="$HOME/Downloads/$3.deb"
    wget "https://github.com/$1/releases/download/$2.deb" -O "$dest"
    sudo dpkg -i "$dest"
    rm "$dest"
}

echo 'Installing alacritty'
install_deb 'alacritty/alacritty' 'v0.4.3/Alacritty-v0.4.3-ubuntu_18_04_amd64' 'alacritty_0.4.3'

echo 'Installing ripgrep'
install_deb 'BurntSushi/ripgrep' '12.1.1/ripgrep_12.1.1_amd64' 'ripgrep_12.1.1'

echo 'Installing fd'
install_deb 'sharkdp/fd' 'v8.1.1/fd_8.1.1_amd64' 'fd_8.1.1'

echo 'Installing bat'
install_deb 'sharkdp/bat' 'v0.15.4/bat_0.15.4_amd64' 'bat_0.15.4'
