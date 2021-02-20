#!/usr/bin/env bash

if pidof polybar;
then
	killall polybar
	herbstclient pad 0 4 4 4 4
	herbstclient pad 1 4 4 4 4
	herbstclient attr theme.title_height 9
	herbstclient attr theme.floating.title_height 0
else
	herbstclient pad 0 44 4 4 4
	herbstclient pad 1 44 4 4 4
	~/.config/polybar/launch.sh
	herbstclient attr theme.title_height 0
fi
