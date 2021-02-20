#!/bin/sh

zscroll -d 0.8 -l 100 -u t -M "/home/barbarossa/.config/polybar/polybar-scripts/check_for_nodes" -m "No windows on desktop" "-b ' Desktop' -s f" -m "Windows on desktop" "-b ' '" "xdotool getactivewindow getwindowname" 2>/dev/null &

# '%{F#868d80} %{F-}
#"-b '%{F#868d80} %{F-}'"
wait
