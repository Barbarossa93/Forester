#!/bin/bash

getVolume(){
	currentVolume=$(pulsemixer --get-volume | awk '{print $1}')
	if [[ $currentVolume -ge 50 ]];
	then
		dunstify -u normal -t 3000 -r 5423 " Volume: $currentVolume%"
	else
		dunstify -u normal -t 3000 -r 5423 " Volume: $currentVolume%"
	fi
}

upVolume(){
	currentVolume=$(pulsemixer --get-volume | awk '{print $1}')
	dunstify -u normal -t 3000 -r 5423 " Volume: $currentVolume%"
}

downVolume(){
	currentVolume=$(pulsemixer --get-volume | awk '{print $1}')
	dunstify -u normal -t 3000 -r 5423 " Volume: $currentVolume%"
}

case "$1" in
	up) currentVolume=$(pulsemixer --get-volume | awk '{print $1}')	
		if [[ "$currentVolume" -ge "100" ]]; then
		pulsemixer --max-volume 100; upVolume
		else
			pulsemixer --change-volume +5; upVolume
		fi;;
	down) pulsemixer --change-volume -5; downVolume;;
	mute) muted=$(pulsemixer --get-mute)
		if [[ "$muted" == "0" ]]; then
			pulsemixer --toggle-mute
			dunstify -u normal -t 3000 -r 5421 ' Audio muted'
		else
			pulsemixer --toggle-mute
			getVolume
		fi;;
esac
