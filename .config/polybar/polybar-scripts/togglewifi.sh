#!/bin/sh

if [ "$(nmcli radio wifi)" = "enabled" ];
then
	nmcli radio wifi off
	notify-send -u normal -t 3000 "WiFi disabled"
	#dunstify -u normal -t 3000 -r 917 "WiFi disabled"
else
	nmcli radio wifi on
	notify-send -u normal -t 3000 "WiFi enabled"
	#dunstify -u normal -t 3000 -r 917 "WiFi enabled"
fi
