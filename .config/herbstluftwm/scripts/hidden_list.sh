#!/usr/bin/env bash

#xdotool getactivewindow windowsize 448 413 windowmove 732 331

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8 --pointer "― " --border=horizontal --reverse --no-info --header=" "'

hc() { ${herbstclient_command:-herbstclient} "$@" ;}
dm() { ${dmenu_command:-fzf} "$@" ;}
dmenu_lines=${dmenu_lines:-10}

case "$1" in

    bring)
        # bring the selected window to the current tag and focus it
        name='Bring │ '
        action() { hc bring "$@" ; }
        ;;

    select_here|*)
        # first focus the tag of the selected window and then select the window
        # this enforces that the setting swap_monitors_to_get_tag is respected:
        # if set, the tag is brought to the focused monitor and the window gets focused.
        # if unset, the focused jumps to the desired window and its position on
        # the screen(s) remains the same.
        name='Select │ '
        action() {
            local winid=$(sed 's,0x[0]*,0x,' <<< "$*")
            local tag=$(hc attr clients."$winid".tag)
            hc lock
            hc use "$tag"
            hc jumpto "$*"
            hc unlock
        }
        ;;

    select)
        # switch to the selected window and focus it
        action() { hc jumpto "$@" ; }
        name='Select │ '
        ;;
esac

#wmctrl -l |cat -n| sed 's/\t/) /g'| sed 's/^[ ]*//' \
id=$(herbstclient try foreach C clients. sprintf ATTR_V '%c.minimized' C and , compare ATTR_V = true , sprintf ATTR_TITLE '%c.title' C substitute TITLE ATTR_TITLE echo C TITLE | cut -d'.' -f2- | grep -v 'wselect.sh' | cat -n | sed 's/\t/) /g'| sed 's/^[ ]*//' \
    | dm -i --prompt "$name") \
    && action $(awk '{ print $2 ; }' <<< "$id")
