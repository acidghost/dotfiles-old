#!/usr/bin/env bash

{   set -e
    cat "$HOME/.config/dunst/base.dunstrc"
    printf "\n%s\n" '# Start of base16-theme'
    cat "$HOME/.antigen/bundles/khamer/base16-dunst/themes/base16-$BASE16_THEME.dunstrc"
}   > "$HOME/.config/dunst/dunstrc"
