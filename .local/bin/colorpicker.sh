#!/usr/bin/env bash
set -euo pipefail

#color=$(gpick -so 2>/dev/null)
color=$(xcolor)

if [ -n "$color" ]; then
	temp=$(mktemp --suffix ".png")
	convert -size 100x100 xc:$color $temp
	dunstify -i $temp -a ColorPicker -u normal "$color"
fi
