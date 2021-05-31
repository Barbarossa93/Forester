#!/usr/bin/env bash

#xdotool getactivewindow windowsize 636 491 windowmove 642 292

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8 --pointer "― " --border=horizontal --reverse --no-info --header=" " --prompt "? | "'

modifier=$(grep "hc keybind" ~/.config/herbstluftwm/autostart | awk '{$1=$1};1' | sed '/^#/d' | cut -d' ' -f3- | sed 's/$Mod/Super/g' | sed 's/Mod1/Alt/g' | awk '{print $1}' | tr -d '"')

description=$(grep 'hc keybind' ~/.config/herbstluftwm/autostart | awk '{$1=$1};1' | sed '/^#/d' | sed 's/^[^#]*#//g' | sed "s/.*hc.*//")

final=$(paste -d '\t' <(echo "$modifier") <(echo "$description") | column -s $'\t' -t)

echo "$final" | fzf
