#!/bin/sh


while true; do
	date="$(date +'%A, %B %d')"
	time="$(date +'%I:%M %p')"
	echo "%{F#87c095}%{F-} $date | %{F#d3a0bc}%{F-} $time"
	sleep 1
done
