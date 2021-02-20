#!/usr/bin/env bash

size=420

art() {
	playerctl metadata mpris:artUrl --follow 2>/dev/null | 
		while read artUrl; do
			curl --output /tmp/large_cover.png $artUrl
			convert /tmp/large_cover.png -resize $sizex$size /tmp/cover.png
		done
}

#art &> /dev/null &
#ncspot; pkill -f playerctl
spotifyd && spt
killall spotifyd
killall cava
killall lyrics-in-terminal
killall ueberzug
tmux kill-session -t Spotify
