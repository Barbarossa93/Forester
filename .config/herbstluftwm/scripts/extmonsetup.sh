#!/usr/bin/env bash

intern=eDP1
extern=VIRTUAL1


update_hlwm() {
    herbstclient detect_monitors
    herbstclient reload
}

if pidof intel-virtual-output; then
    xrandr --output "$extern" --off --output "$intern" --auto
    pkill intel-virtual-o
    killall redshift
	update_hlwm
    redshift &
    killall lemonbar
    bar.sh &
    #~/.config/polybar/launch.sh
else
    optirun intel-virtual-output;
    #wait
    while :; do
        xrandr | grap VIRTUAL2
        if [ $? -eq 0 ]; then
            break
        fi
    done
    xrandr --output "$intern" --primary --auto --rotate normal --output "$extern" --auto --rotate normal --right-of "$intern"
    DISPLAY=:8 xset s 180 120
		update_hlwm
    #systemctl restart clightd.service
    DISPLAY=:8 redshift &
    #hsetroot -fill ~/Pictures/gloomy_pixel_forest_small.jpg
    herbstclient pad 1 44 4 4 4
    killall lemonbar
    bar.sh &
    ext_bar.sh &
    #~/.config/polybar/launch.sh
fi
