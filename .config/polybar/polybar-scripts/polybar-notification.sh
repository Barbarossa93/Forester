#!/bin/sh

trap 'pkill -9 polybar-notification; kill $(jobs -rp); rm .history' SIGINT SIGTERM EXIT

if [ -f ".history" ]; then
	rm .history
fi

main () {
	dejsonified0=$(echo "$json_line" | jq -r '.app_name' 2>/dev/null)
	if [[ "$dejsonified0" == "notify-send" ]]; then
		dejsonified0=
	fi
	dejsonified1=$(echo "$json_line" | jq -r '.summary' 2>/dev/null)
	dejsonified2=$(echo "$json_line" | jq -r '.body' 2>/dev/null)
	lines1=$(echo "$dejsonified1" | wc -l)
	lines2=$(echo "$dejsonified2" | wc -l)
	if [ $lines1 -gt 1 ] || [ $lines2 -gt 1 ]; then
	       if [ ! -z "$dejsonified0" ]; then
			echo "%{F#868d80} %{F-}$1$dejsonified0%{F-}"
			sleep 1.5
	       fi
		while read line; do
			linelength=$(echo ${#line})
			if [[ $linelength -gt 100 ]]; then
				trunc_line=$(echo $line | cut -c 1-100)
				ell_line="$trunc_line..."
				echo "%{F#868d80} %{F-}$1$ell_line%{F-}"
				sleep 1.5
			else
			echo "%{F#868d80} %{F-}$1$line%{F-}"
			sleep 1.5
			fi
		done <<< "$dejsonified1"
		while read line; do
			linelength=$(echo ${#line})
			if [ ! -z "$dejsonified2" ]; then
				if [[ $linelength -gt 100 ]]; then
					trunc_line=$(echo $line | cut -c 1-100)
					ell_line="$trunc_line..."
					echo "%{F#868d80} %{F-}$1$ell_line%{F-}"
					sleep 1.5
				else
					echo "%{F#868d80} %{F-}$1$line%{F-}"
					sleep 1.5
				fi
			fi
		done <<< "$dejsonified2"
	else
		if [ ! -z "$dejsonified0" ]; then
			echo "%{F#868d80} %{F-}$1$dejsonified0%{F-}"
			sleep 2
		fi
		length1=$(echo ${#dejsonified1})
		if [[ $length1 -gt 100 ]]; then
			trunc_dejson1=$(echo $dejsonified1 | cut -c 1-100)
			ell_dejson1="$trunc_dejson1..."
			echo "%{F#868d80} %{F-}$1$ell_dejson1%{F-}"
			sleep 3
		else
		echo "%{F#868d80} %{F-}$1$dejsonified1%{F-}"
		sleep 3
		fi
		if [ ! -z "$dejsonified2" ]; then
			length2=$(echo ${#dejsonified2})
			if [[ $length2 -gt 100 ]]; then
				trunc_dejson2=$(echo $dejsonified2 | cut -c 1-100)
				ell_dejson2="$trunc_dejson2..."
				echo "%{F#868d80} %{F-}$1$ell_dejson2%{F-}"
				sleep 2
			else
				echo "%{F#868d80} %{F-}$1$dejsonified2%{F-}"
				sleep 2
			fi
		fi
	fi
	echo "" >> .history
	echo "$(date)" >> .history
	echo "$json_line" |  jq -r 'to_entries|map("\(.key): \(.value|tostring)")|.[]' 2>/dev/null >> .history
	echo "" >> /tmp/output
}

touch /tmp/output
touch .history
echo "" >> /tmp/output

tail -n 1 -F /tmp/output 2>/dev/null |
	while read -r raw_json; do
		json_line=$(echo "$raw_json" | tr -d '\n' | sed -E 's:,(\s*}):\1:g' | sed -E -n 'H; x; s:,(\s*\n\s*}):\1:; P; ${x; p}' | sed '1 d')
		test=$(echo "$json_line")
		if [[ "$test" == "" ]]; then
			withlock .title-LOCK /home/barbarossa/.config/polybar/polybar-scripts/polybar-window-title.sh 2>/dev/null &
		else
			#pkill -f polybar-clock.sh
			kill $(jobs -rp) &>/dev/null
			wait $(jobs -rp) &>/dev/null
			test_for_urgency=$(echo "$json_line" | grep "urgency")
			if [[ "$test_for_urgency" == "" ]]; then
				main %{F#a7c080}
			else
				urgency=$(echo "$json_line" |  jq -r '.hints.urgency' 2>/dev/null)
				if [[ "$urgency" == "0" ]]; then
					main %{F#89beba}
				elif [[ "$urgency" == "1" ]]; then
					main %{F#a7c080}
				elif [[ "$urgency" == "2" ]]; then
					main %{F#e68183}
				else
					main %{F#d8caac}
				fi
			fi

		fi
	done

##TODO
#make variables for certain settings like duration, history file, output file
