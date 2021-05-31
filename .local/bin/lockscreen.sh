#!/bin/bash

sunpape(){
	currentWall=$(sunpaper.sh -r | grep "Current Paper" | awk '{print $3}')
	if [[ "$currentWall" == "0.jpg" ]]; then
		timelist=$(sunpaper.sh -r | tail -n8 | awk '{print $1}')
		current=$(date +"%H:%M")
		readarray timearray <<< $timelist
		c=0
		for i in "${timearray[@]}"; do
			if [[ "$current" > "$i" ]]; then
				c=$(( c + 1 ))
				continue
			else
				currentWall="$(( c + 1 )).jpg"
			fi
		done
		if [ "$c" -eq 8 ]; then
			currentWall="1.jpg"
		fi
	fi
	
	if [ ! -f "$HOME/.cache/i3lock/$currentWall" ]; then
		sunlock_bg_generator.sh
	fi
}

ilock() {
	i3lock -i /home/barbarossa/.cache/i3lock/$currentWall -t --datestr "Password:" -c $1ff -n --composite \
			--datecolor=$2ff --datepos='w/2+x:h/2-30' --date-font="berry:style=Bold" --datesize=11 \
		 	--wrong-font="berry" --verif-font="berry" --veriftext="verifying..." --wrongsize=11 \
			--verifsize=11 --verifcolor=$3 --wrongcolor=$4 --bar-indicator --bar-total-width 280 --bar-direction=1 \
			--bar-position='w/2-140+x:h/2+30' --bar-color=$1 --bar-max-height=25 --bar-base-width=50 --bar-count=55 \
			--keyhlcolor=$5 --bshlcolor=$4 --ringvercolor=$1 --ringwrongcolor=$1 --pass-media-keys \
			--pass-power-keys --pass-screen-keys --pass-volume-keys --greetertext "________________________________________" \
			--force-clock --timestr="%B %d, %Y at %I:%M %p" --greeterpos="w/2+x:h/2+30" --greeter-font="berry" --greetercolor=$2 --greetersize=14 \
			--bar-step 9 --bar-periodic-step 9 --indpos="w/2+x:h/2-10" --timepos="w/2+x:h/2+45" --time-font="berry" --timesize=11 \
			--timecolor=$2 --modsize 11 --modifpos="w/2:h/2+5"
}

DaySuffix() {
  case `date +%d` in
    1|21|31) echo "st";;
    2|22)    echo "nd";;
    3|23)    echo "rd";;
    *)       echo "th";;
  esac
}

xlock() {
	XSECURELOCK_AUTH_BACKGROUND_COLOR=$1 XSECURELOCK_AUTH_FOREGROUND_COLOR=$2 \
		XSECURELOCK_AUTH_WARNING_COLOR=$3 XSECURELOCK_SAVER="/home/barbarossa/.local/bin/background.sh" \
		XSECURELOCK_SHOW_HOSTNAME=1 XSECURELOCK_COMPOSITE_OBSCURER=0 XSECURELOCK_BURNIN_MITIGATION=0 XSECURELOCK_SHOW_USERNAME=0 \
		XSECURELOCK_PASSWORD_PROMPT=cursor XSECURELOCK_SHOW_DATETIME=1 XSECURELOCK_FONT="berry:pixelsize=11:antialias=false" \
		XSECURELOCK_DATETIME_FORMAT="%A, %B %d`DaySuffix` at %I:%M %p" xsecurelock -- /usr/bin/xdotool key 0
}

# Clear gpg-cache and ssh keys prior to lock. pam-gnupg starts it up again after unlock
gpg-connect-agent --no-autostart reloadagent /bye

# Clear all clipboard & selections
xclip -selection clipboard /dev/null
xclip -selection primary /dev/null
xclip -selection secondary /dev/null

#if lock fails, relock the screen
sunpape
if [[ "$currentWall" == "1.jpg" ]] || [[ "$currentWall" == "2.jpg" ]] || [[ "$currentWall" == "8.jpg" ]]; then
	#ilock 323d43 d8caac 87c095 e68183 a7c080 || lockscreen.sh
	xlock "#323d43" "#d8caac" "#e68183" || lockscreen.sh
else
	#ilock f8f0dc 5c6a72 35a77c f85552 8da101 || lockscreen.sh
	xlock "#f8f0dc" "#5c6a72" "#f85552" || lockscreen.sh
fi
