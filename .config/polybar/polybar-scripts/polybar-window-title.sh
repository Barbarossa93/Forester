#!/usr/bin/env bash

while true; do
	title=$(xdotool getactivewindow getwindowname)
	truncate=$(echo "$title" | awk 'length > 97{$0=substr($0,0,98)"..."}1')
	node_check=$(bspc query -N -d focused -n .window.\!hidden)
	focused_node=$(bspc query -T -n)
	# Should return tiled, pseudo_tiled, floating, or fullscreen
	state=$(echo -n "$focused_node" | jq -r '.client.state')
	locked=$(echo -n "$focused_node" | jq -r '.locked')
	sticky=$(echo -n "$focused_node" | jq -r '.sticky')
	private=$(echo -n "$focused_node" | jq -r '.private')
	marked=$(echo -n "$focused_node" | jq -r '.marked')

	unset state_list
	if [[ "$state" == "pseudo_tiled" ]]; then
		state_list=${state_list}${state_list:+,}
	elif [[ "$state" == "floating" ]]; then
		state_list=${state_list}${state_list:+,}
	elif [[ "$state" == "fullscreen" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$locked" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$sticky" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$private" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi
	if [[ "$marked" == "true" ]]; then
		state_list=${state_list}${state_list:+,}
	fi

	sani_list=$(echo -n "$state_list" | tr ',' ' ')
	
	if [ -z "$sani_list" ]; then
		sani_list=""
	else
		sani_list=" $sani_list"
	fi

	if [ -n "$node_check" ]; then
		echo "%{F#999f93}%{F-}%{F#7c8377}$sani_list%{F-} $truncate"
	else
		echo "%{F#999f93}%{F-} Desktop"
	fi
	sleep 0.2
done
