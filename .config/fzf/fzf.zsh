# Setup fzf
# ---------
if [[ ! "$PATH" == */home/acidghost/.vim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/acidghost/.vim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/acidghost/.vim/plugged/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/acidghost/.vim/plugged/fzf/shell/key-bindings.zsh"
