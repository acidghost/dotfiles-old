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


autoload -U zmv


forgit_log=fglo
forgit_diff=fgd
forgit_add=fga
forgit_reset_head=fgrh
forgit_ignore=fgi
forgit_restore=fgcf
forgit_clean=fgclean
forgit_stash_show=fgss

export ZSH_TMUX_FIXTERM=true
export ZSH_TMUX_UNICODE=true

export BASE16_SHELL_HOOKS="$HOME/.scripts/base16"

export ANTIGEN_LOG="$HOME/.log/antigen.log"
source ~/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle battery
antigen bundle colorize
antigen bundle colored-man-pages
antigen bundle docker
antigen bundle emoji
antigen bundle fancy-ctrl-z
antigen bundle git
antigen bundle gitignore
antigen bundle thefuck
antigen bundle themes
antigen bundle tmux
antigen bundle vagrant
antigen bundle vi-mode
antigen bundle virtualenv
antigen bundle web-search
antigen bundle z

antigen bundle chriskempson/base16-shell
antigen theme romkatv/powerlevel10k
antigen bundle wfxr/forgit
antigen bundle fnune/base16-fzf
antigen bundle jordiorlando/base16-rofi
antigen bundle HaoZeke/base16-zathura@main
antigen bundle khamer/base16-dunst

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# dotfiles management
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export EDITOR=nvim
export PAGER=less
export LESS="R"

[[ -d ~/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"
[[ -d ~/.cargo/bin ]] && export PATH="$PATH:$HOME/.cargo/bin"
[[ -e ~/.path ]] && source ~/.path
export PATH="$HOME/.scripts:$PATH"
export AWKPATH="$HOME/.scripts/awk:$AWKPATH"

[[ -e ~/.aliases ]] && source ~/.aliases

export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
source ~/.local/bin/virtualenvwrapper_lazy.sh

# opam configuration
test -r /home/acidghost/.opam/opam-init/init.zsh && . /home/acidghost/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# bat
export BAT_THEME=base16-256
export BAT_STYLE=numbers,grid
# accomodate for "less -J"
# alias bat="bat --terminal-width -2"

# FZF
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
export FZF_TMUX=1
export FZF_DEFAULT_COMMAND="fd --type f"
[ -f ~/.fzf_theme ] && source ~/.fzf_theme

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf "$@" --preview "eval 'echo \$'{}" "$@" ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    $EDITOR)      fzf "$@" --preview 'bat --color always -p {}' ;;
    *)            fzf "$@" ;;
  esac
}

_z_jump() {
    local res
    res=`_z -l 2>&1 | fzf --tac --preview 'tree {}' --reverse`
    [ $? -eq 0 ] && {
        local p=`echo -n "$res" | sed 's/^[0-9]*\.*[0-9]*[[:space:]]*\/\(.*\)$/\/\1/'`
        zle reset-prompt
        LBUFFER+="cd $p"
    }
}
zle     -N   _z_jump
bindkey '^j' _z_jump

eval $(thefuck --alias)

export QT_QPA_PLATFORMTHEME=qt5ct
