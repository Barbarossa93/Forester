#!/usr/bin/env bash

unbuffer alsactl monitor |
	while read -r line; do
	echo $line | grep Volume &> /dev/null
		if [ $? -eq 0 ]; then
			state=$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')
			val=$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)
			if [[ "$state" == "[off]" ]]; then
				echo "$val!"
			else
				echo "$val"
			fi
		fi
	done
