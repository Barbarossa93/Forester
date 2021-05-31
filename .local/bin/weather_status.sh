#!/usr/bin/env bash

icon=$(cat /tmp/weather/weather-icon)
temp=$(cat /tmp/weather/weather-degree)
status=$(weather_trimmer.sh)
quote=$(cat /tmp/weather/weather-quote | head -n1)

notify-send -u normal -t 3000 "$(echo -e "$icon$temp\n$status\n$quote")"
