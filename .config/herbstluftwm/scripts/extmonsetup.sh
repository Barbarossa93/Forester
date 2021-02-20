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
		update_hlwm
    ~/.config/polybar/launch.sh
else
    optirun intel-virtual-output;
    wait
    xrandr --output "$intern" --primary --auto --rotate normal --output "$extern" --auto --rotate normal --right-of "$intern"
    DISPLAY=:8 xset s 420 179
		update_hlwm
    systemctl restart clightd.service
    hsetroot -fill ~/Pictures/gloomy_pixel_forest_small.jpg
    herbstclient pad 1 44 4 4 4
    ~/.config/polybar/launch.sh
fi
