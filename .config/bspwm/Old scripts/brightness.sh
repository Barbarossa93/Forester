#!/usr/bin/env zsh

zmodload zsh/mathfunc

upBrightness() {
	currentBrightness=$((int(rint($(light -G)))))
	dunstify -u normal -t 3000 -r 2943 " Brightness: $currentBrightness%"
}

downBrightness(){
	currentBrightness=$((int(rint($(light -G)))))
	dunstify -u normal -t 3000 -r 2943 " Brightness: $currentBrightness%"
}

case "$1" in
	up) light -A 5; upBrightness;;
	down) light -U 5; downBrightness;;
esac
