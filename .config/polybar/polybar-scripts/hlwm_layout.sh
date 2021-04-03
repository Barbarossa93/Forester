#!/usr/bin/env bash

while true; do
	layout=$(herbstclient attr tags.focus.tiling.focused_frame.algorithm)

	if [[ "$layout" == "horizontal" ]]; then
		icon=
	elif [[ "$layout" == "vertical" ]]; then
		icon=
	elif [[ "$layout" == "max" ]]; then
		icon=
	elif [[ "$layout" == "grid" ]]; then
		icon=
	fi
	echo "$icon"
	sleep 0.2
done
