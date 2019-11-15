# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/acidghost/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle battery
antigen bundle colorize
antigen bundle colored-man-pages
antigen bundle docker
antigen bundle emoji
antigen bundle fancy-ctrl-z
antigen bundle git
antigen bundle gitignore
antigen bundle themes
antigen bundle tmux
antigen bundle vi-mode
antigen bundle virtualenv
antigen bundle web-search
antigen bundle z

antigen bundle chriskempson/base16-shell

antigen theme romkatv/powerlevel10k

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# dotfiles management
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export EDITOR=vim
export ZSH_TMUX_FIXTERM=true

[[ -d ~/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d ~/.cargo/bin ]] && export PATH="$PATH:$HOME/.cargo/bin"
[[ -e ~/.path ]] && source ~/.path

[[ -e ~/.aliases ]] && source ~/.aliases

