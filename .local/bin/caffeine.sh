#!/usr/bin/env bash

if [[ $(xset q | grep Enabled | awk '{print $3}') == "Enabled" ]];
then
    xset -dpms s off && DISPLAY=:8 xset -dpms s off
    pkill idle.sh
    notify-send -u normal -t 3000 " Caffeine Enabled"    
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Enabled"
else
    xset +dpms s on && DISPLAY=:8 xset +dpms s on
    xset s 180 && DISPLAY=:8 xset s 180
    xset dpms 300 && DISPLAY=:8 xset dpms 300
    idle.sh 10 "systemctl hibernate" &
    notify-send -u normal -t 3000 " Caffeine Disabled"
    #dunstify -u normal -t 3000 -r 5534 " Caffeine Disabled"
fi
