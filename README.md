# .dotfiles

## Installation to a new machine

#### 1. Clone the repository
`git clone --bare <git-repo-url> $HOME/.dotfiles`
#### 2. Create alias to manipulate the bare repository
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
#### 3. Checkout repository's contents
`dotfiles checkout`
#### 4. Install dependencies
`./install_dotfiles.sh`
#### 5. Install `zsh`
`sudo apt install zsh`
#### 6. Logout / login from session
