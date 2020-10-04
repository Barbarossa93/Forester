#!/bin/sh

show() {
	xdotool search --name Polybar windowmove --relative -- 0 1
	xdotool search --name Polybar windowmove --relative -- 0 1		
	for i in $(seq -4 36); do
		bspc config top_padding $i
		xdotool search --name Polybar windowmove --relative -- 0 1
	done
}

hide() {	
	for i in $(seq 36 -1 -4); do
		xdotool search --name Polybar windowmove --relative -- 0 -1
		bspc config top_padding $i
	done
	xdotool search --name Polybar windowmove --relative -- 0 -1
	xdotool search --name Polybar windowmove --relative -- 0 -1	
}

toggle() {
	pad=$(bspc config top_padding)
	if [[ "$pad" == "36" ]]; then
		hide
	else
		show
	fi
}

case "$1" in
	-s|--show)
		show
		;;
	-h|--hide)
		hide
		;;
	-t|--toggle)
		toggle
		;;
	*)
		toggle
		;;
esac
