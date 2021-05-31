#!/usr/bin/bash

hex_prefix=0x
hex_num=$(printf '%x' $XSCREENSAVER_WINDOW)
window_id=$hex_prefix$hex_num

sunpape(){
	currentWall=$(/home/barbarossa/.local/bin/sunpaper.sh -r | /usr/bin/grep "Current Paper" | /usr/bin/awk '{print $3}')
	if [[ "$currentWall" == "0.jpg" ]]; then
		timelist=$(/home/barbarossa/.local/bin/sunpaper.sh -r | /usr/bin/tail -n8 | /usr/bin/awk '{print $1}')
		current=$(/usr/bin/date +"%H:%M")
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
	
	if [ ! -f "/home/barbarossa/.cache/i3lock/$currentWall" ]; then
		/home/barbarossa/.local/bin/sunlock_bg_generator.sh
	fi
}
sunpape
/usr/bin/sxiv -b -g 1920x1080+0+0 -e $window_id /home/barbarossa/.cache/i3lock/$currentWall

#/usr/bin/sxiv -b -g 1920x1080+0+0 -e $window_id /home/barbarossa/Pictures/lock_background.png
