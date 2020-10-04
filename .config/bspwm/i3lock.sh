#!/bin/sh

pkill -f cmatrixterm

cachepath=$HOME/.cache/i3lock

logical_px() {
	# get dpi value from xrdb
	local DPI
	DPI=$(cat ~/.Xresources | grep -oP 'Xft.dpi:\s*\K\d+' | bc)
	if [ -z "$DPI" ]; then
		DPI=$(xdpyinfo | sed -En "s/\s*resolution:\s*([0-9]*)x([0-9]*)\s.*/\\$2/p" | head -n1)
	fi

	# return the default value if no DPI is set
	if [ -z "$DPI" ]; then
		echo "$1"
	else
		local SCALE
		SCALE=$(echo "scale=2; $DPI / 96.0" | bc)

		# check if scaling the value is worthy
		if [ "$(echo "$SCALE > 1.25" | bc -l)" -eq 0 ]; then
			echo "$1"
		else
			echo "$SCALE * $1 / 1" | bc
		fi
	fi
}

gen_image() {
	if [[ ! -d $HOME/.cache/i3lock ]]; then
		mkdir $HOME/.cache/i3lock
	fi
	echo "Caching image..."
	rectangles=" "
	SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
	for RES in $SR; do
		SRA=(${RES//[x+]/ })
		CX=$((SRA[2] + $(logical_px 25 1)))
		CY=$((SRA[1] - $(logical_px 30 2)))
		rectangles+="rectangle $CX,$CY $((CX+$(logical_px 300 1))),$((CY-$(logical_px 80 2))) "
	done
	convert $1 -draw "fill #323d43ff $rectangles" $cachepath/rectangle.png
	echo "Finished caching user image"

}

lock() {
	playerctl pause
	i3lock -i $cachepath/rectangle.png -n -t -e \
		--force-clock --pass-media-keys --pass-screen-keys --pass-volume-keys \
		--keyhlcolor=a7c080 --bshlcolor=a7c080 --wrongcolor=e68183 --verifcolor=868d80 \
		--timepos='x+110:h-70' --datepos='x+43:h-45' --indpos='x+260:h-54' --modifpos -50:-50 --greeterpos='x+260:h-72' \
		--clock --date-align 1 --datestr "Hello $USER" --timestr="%I:%M %p" --greetertext="Locked" \
		--bar-indicator --redraw-thread --bar-direction=1 --bar-width=15 \
		--bar-step 20 --bar-max-height 20 --bar-base-width 20 --bar-position=1080 \
		--bar-color=323d4300 --timecolor=d8caacff --datecolor=d8caacff --greetercolor=87c095 \
		--ringvercolor=00000000 --ringwrongcolor=00000000 --verifsize=14 --wrongsize=14 --greetersize=16 \
		--time-font="terra" --date-font="terra" --layout-font="terra" --verif-font="terra" --wrong-font="terra" --greeter-font="terra"
	playerctl play
}

show_help(){
	cat <<-EOF
	Usage :
	 mantablockscreen [OPTION]

	Avaible options:
	 -i, --image             Generate cache image
	 -h, --help              Show this help

	 No options given starts the lock screen.

	EOF
}

case $1 in
	-i|--image)
		gen_image $2
		;;
	-h|--help)
		show_help
		;;
	*)
		lock
		;;
esac
