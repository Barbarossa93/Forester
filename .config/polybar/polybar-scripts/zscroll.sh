#!/bin/sh

zscroll -d 0.8 -l 100 -u t -M "/home/barbarossa/.config/polybar/polybar-scripts/check_for_nodes" -m "No windows on desktop" "-b '%{F#d7beda} %{F-}Desktop' -s f" -m "Windows on desktop" "-b '%{F#d7beda} %{F-}'" "xdotool getwindowfocus getwindowname" &

wait
