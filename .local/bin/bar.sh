#!/usr/bin/env bash

trap "killall lemonbar" SIGINT SIGTERM

. "$HOME/Public/neat-things/colorschemes/forest-night-xresources/forest-night.sh"

#FONTS="-o 0 -f berry-9 -o 1 -f SijiPlus-8 -o 0 -f Twemoji-8"
FONTS="-f -spectrum-berry-medium-r-normal-sans-11-80-75-75-m-50-iso10646-1 -f -wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"
WIDTH=1522 # bar width
HEIGHT=24 # bar height
XOFF=199 # x offset
YOFF=12 # y offset
BBG=${background} # bar background color
BFG=${foreground}
BDR=${color8}

# Status constants
# Change these to modify bar behavior
DESKTOP_COUNT=10
BATTERY_10=98
BATTERY_9=90
BATTERY_8=80
BATTERY_7=70
BATTERY_6=60
BATTERY_5=50
BATTERY_4=40
BATTERY_3=30
BATTERY_2=20
BATTERY_1=10

# Sleep constnats
BATTERY_SLEEP=10
WIRELESS_SLEEP=10
DATE_SLEEP=5

#Colors
BLACK="%{F$color0}"
RED="%{F$color1}"
GREEN="%{F$color2}"
YELLOW="%{F$color3}"
BLUE="%{F$color4}"
MAGENTA="%{F$color5}"
CYAN="%{F$color6}"
WHITE="%{F$color7}"
GREY="%{F$color8}"
ORANGE="%{F$color16}"
CLR="%{B-}%{F-}"

# Formatting Strings
# I would reccomend not touching these :D
SEP=" ${GREY}|${CLR} "
SEP2="${GREY}|${CLR} "

# Glyphs used for both bars
GLYWIN=$(echo -e "\ue1d7")
GLYLIGHT1=$(echo -e "\ue025")
GLYLIGHT2=$(echo -e "\ue023")
GLYLIGHT3=$(echo -e "\ue024")
GLYLIGHT4=$(echo -e "\ue022")
GLYTIME=$(echo -e "\ue017")
GLYVOL1=$(echo -e "\ue04e")
GLYVOL2=$(echo -e "\ue050")
GLYVOL3=$(echo -e "\ue050")
GLYVOL4=$(echo -e "\ue05d")
GLYVOL5=$(echo -e "\ue05d")
GLYVOLM=$(echo -e "\ue04f")
GLYBAT1=$(echo -e "\ue242")
GLYBAT2=$(echo -e "\ue243")
GLYBAT3=$(echo -e "\ue244")
GLYBAT4=$(echo -e "\ue245")
GLYBAT5=$(echo -e "\ue246")
GLYBAT6=$(echo -e "\ue247")
GLYBAT7=$(echo -e "\ue248")
GLYBAT8=$(echo -e "\ue249")
GLYBAT9=$(echo -e "\ue24a")
GLYBAT10=$(echo -e "\ue24b")
GLYBATCHG=$(echo -e "\ue23a")
GLYWLAN1=$(echo -e "\ue218")
GLYWLAN2=$(echo -e "\ue219")
GLYWLAN3=$(echo -e "\ue21a")
GLYWLAN4=$(echo -e "\ue21a")
GLYWLAN5=$(echo -e "\ue21a")
GLYWS1=$(echo -e "\ue1a0")
GLYWS2=$(echo -e "\ue1a8")
GLYWS3=$(echo -e "\ue1d5")
GLYWS4=$(echo -e "\ue1ec")
GLYWS5=$(echo -e "\ue1e0")
GLYWS6=$(echo -e "\ue1a7")
GLYWS7=$(echo -e "\ue05c")
GLYWS8=$(echo -e "\ue1f5")
GLYWS9=$(echo -e "\ue1da")
GLYWS10=$(echo -e "\ue027")
GLYLYTH=$(echo -e "\ue26b")
GLYLYTV=$(echo -e "\ue004")
GLYLYTM=$(echo -e "\ue000")
GLYLYTG=$(echo -e "\ue005")

PANEL_FIFO=/tmp/panel-fifo
OPTIONS="-d ${FONTS} -g ${WIDTH}x${HEIGHT}+${XOFF}+${YOFF} -B ${BBG} -F ${BFG} -u 0 -a 25"

[ -e "${PANEL_FIFO}" ] && rm "${PANEL_FIFO}"
mkfifo "${PANEL_FIFO}"

workspaces() {
	herbstclient --idle "tag_*" 2>/dev/null | {

		while true; do
			# Read tags into $tags as array
			IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status)"
			{
				for f in "${tags[@]}" ; do
					status+=( ${f:0:1} )
				done

				for i in "${!tags[@]}"; do
					if [[ ${tags[$i]} == *"1"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS1}"
					elif [[ ${tags[$i]} == *"2"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS2}"
					elif [[ ${tags[$i]} == *"3"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS3}"
					elif [[ ${tags[$i]} == *"4"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS4}"
					elif [[ ${tags[$i]} == *"5"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS5}"
					elif [[ ${tags[$i]} == *"6"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS6}"
					elif [[ ${tags[$i]} == *"7"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS7}"
					elif [[ ${tags[$i]} == *"8"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS8}"
					elif [[ ${tags[$i]} == *"9"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS9}"
					elif [[ ${tags[$i]} == *"0"* ]]; then
						tags[$i]=${status[$i]}"${GLYWS10}"
					else
						break && notify-send "Hlwm status broke"
					fi
				done
				count=1
				for i in "${tags[@]}" ; do
					# Read the prefix from each tag and render them according to that prefix
					if [ "$count" -eq 1 ];then
						echo "WORKSPACES "
					fi
					case ${i:0:1} in
						'#')
							# the tag is viewed on the focused monitor
							# TODO Add your formatting tags for focused workspaces
							echo "${GREEN}"
							;;
						':')
							# : the tag is not empty
							# TODO Add your formatting tags for occupied workspaces
							echo "${WHITE}"
							;;
						'!')
							# ! the tag contains an urgent window
							# TODO Add your formatting tags for workspaces with the urgent hint
							echo "${RED}"
							;;
						'-')
							# - the tag is viewed on a monitor that is not focused
							# TODO Add your formatting tags for visible but not focused workspaces
							echo "${CYAN}"
							;;
						*)
							# . the tag is empty
							# There are also other possible prefixes but they won't appear here
							echo "${GREY}" # Add your formatting tags for empty workspaces
							;;
					esac

					if [ $count -eq 10 ]; then
						count=0
					fi

					echo "%{A1:herbstclient use $count:} ${i:1} %{A}${CLR}"
					count=$(( count + 1 ))
				done

					} | tr -d "\n"

				echo

						# wait for next event from herbstclient --idle
						read -r || break
					done
				} 2>/dev/null
		}

	workspaces > "${PANEL_FIFO}" &

	layout() {
		layouticon() {
			layout=$(herbstclient attr tags.focus.tiling.focused_frame.algorithm)
			count=$(herbstclient attr tags.focus.curframe_wcount)

			if [[ "$layout" == "horizontal" ]]; then
				icon="${GLYLYTH}"
			elif [[ "$layout" == "vertical" ]]; then
				icon="${GLYLYTV}"
			elif [[ "$layout" == "max" ]]; then
				icon="${GLYLYTM}"
			elif [[ "$layout" == "grid" ]]; then
				icon="${GLYLYTG}"
			fi

			if [[ "$layout" == "max" ]]; then
				echo "LAYOUT ${ORANGE}$icon%{F-} $count"
			else
				echo "LAYOUT ${ORANGE}$icon%{F-}"
			fi
		}
	layouticon
	herbstclient watch tags.focus.tiling.focused_frame.algorithm
	herbstclient --idle "attribute_changed" |
		while read -r line; do
			layouticon
		done
	}

layout > "${PANEL_FIFO}" &

window_title() {
	echo "TITLE ${RED}${GLYWIN}${CLR} Desktop"
	herbstclient --idle "^(focus|window_title)_changed" |
		while read -r focus; do
			title=$(herbstclient attr clients.focus.title)
			length=$(echo $title | wc -c)
			# Tiny delay b/c race condition with workspaces function (title would appear at end of workspaces)
			# Since tag changes coincide with focus changes, so not sure of a cleaner way to account for this
			sleep 0.05
			if [ "$length" -ge 100 ]; then
				trunc=$(echo $title | cut -c -100)
				title="$trunc..."
			fi
			if [ -z "$title" ]; then
				title="Desktop"
			fi
			echo "TITLE ${RED}${GLYWIN}${CLR} %{A3:herbstclient close_and_remove:}$title%{A}"
		done
	}

window_title > "${PANEL_FIFO}" &

volume()
{
	volicon() {
		local vol="$(amixer get Master | grep "Mono" | awk '{print $4}' | tr -d -c 0-9)"
		local mut="$(amixer get Master | grep "Mono" | awk '{print $6}' | sed -r '/^\s*$/d')"

		if [[ ${mut} = "[off]" ]]; then
			label="${GREY}${GLYVOLM} %{A1:amixer set Master toggle:}M%{A}${CLR}"
		elif [[ "$vol" -lt 20 ]]; then
			label="${CYAN}${GLYVOL1}${CLR} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 40 ]]; then
			label="${CYAN}${GLYVOL2}${CLR} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 60 ]]; then
			label="${CYAN}${GLYVOL3}${CLR} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		elif [[ "$vol" -lt 80 ]]; then
			label="${CYAN}${GLYVOL4}${CLR} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		else
			label="${CYAN}${GLYVOL5}${CLR} %{A1:amixer set Master toggle:}%{A4:amixer set Master 5%+:}%{A5:amixer set Master 5%-:}$vol%%%{A}%{A}%{A}"
		fi

		echo "VOLUME ${label}${CLR}"
	}
volicon
unbuffer alsactl monitor |
	while read -r monitor; do
		volicon
	done
}

volume > "${PANEL_FIFO}" &

brightness() {
	lighticon() {
		local light=$(xbacklight)
		local rounded=$(echo "($light)/1" | bc)
		if [[ "$rounded" -lt 25 ]]; then
			echo "BRIGHTNESS ${YELLOW}${GLYLIGHT1}${CLR} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A}"
		elif [[ "$rounded" -lt 50 ]]; then
			echo "BRIGHTNESS ${YELLOW}${GLYLIGHT2}${CLR} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A}"
		elif [[ "$rounded" -lt 75 ]]; then
			echo "BRIGHTNESS ${YELLOW}${GLYLIGHT3}${CLR} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A}"
		else
			echo "BRIGHTNESS ${YELLOW}${GLYLIGHT4}${CLR} %{A4:xbacklight -inc 5:}%{A5:xbacklight -dec 5:}$rounded%%%{A}%{A}"
		fi
	}
lighticon
brightness-watcher.py |
	while read -r line; do
		lighticon
	done
}

brightness > "${PANEL_FIFO}" &

battery()
{
	while true; do
		local cap="$(cat /sys/class/power_supply/BAT1/capacity)"
		local stat="$(cat /sys/class/power_supply/BAT1/status)"

		if [[ ${stat} = "Charging" ]]; then
			echo "BATTERY ${GREEN}${GLYBATCHG}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_1} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT1}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_2} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT2}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_3} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT3}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_4} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT4}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_5} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT5}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_6} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT6}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_7} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT7}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_8} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT8}${CLR} %{A1:powertime:}${cap}%%%{A}"
		elif [[ ${cap} -lt ${BATTERY_9} ]]; then
			echo "BATTERY ${GREEN}${GLYBAT9}${CLR} %{A1:powertime:}${cap}%%%{A}"
		else
			echo "BATTERY ${GREEN}${GLYBAT10}${CLR} %{A1:powertime:}${cap}%%%{A}"
		fi

		sleep ${BATTERY_SLEEP}
	done
}

battery > "${PANEL_FIFO}" &

wireless()
{
	while true; do
		local wifi=$(nmcli -g IN-USE,SSID d wifi list | grep "*" | cut -d':' -f2)
		local strength=$(nmcli -g IN-USE,SIGNAL d wifi list | grep "*" | cut -d':' -f2)

		if [[ -z $wifi ]]; then
			local wifi="Disconnected"
			echo "WIRELESS ${GREY}${GLYWLAN1}${CLR} %{A1:urxvtdc -e nmtui:}${wifi}%{A}"
		elif [[ "$strength" -lt 20 ]]; then
			echo "WIRELESS ${BLUE}${GLYWLAN1}${CLR} ${strength}%%"
		elif [[ "$strength" -lt 40 ]]; then
			echo "WIRELESS ${BLUE}${GLYWLAN2}${CLR} ${strength}%%"
		elif [[ "$strength" -lt 60 ]]; then
			echo "WIRELESS ${BLUE}${GLYWLAN3}${CLR} ${strength}%%"
		elif [[ "$strength" -lt 80 ]]; then
			echo "WIRELESS ${BLUE}${GLYWLAN4}${CLR} ${strength}%%"
		else
			echo "WIRELESS ${BLUE}${GLYWLAN5}${CLR} ${strength}%%"
		fi

		sleep ${WIRELESS_SLEEP}
	done
}

wireless > "${PANEL_FIFO}" &

clock()
{
	while true; do
		local clock="$(date +'%I:%M %p')"
		echo "CLOCK ${MAGENTA}${GLYTIME}${CLR} %{A1:notify-send -u normal -t 3000 ' $(date '+%A, %B %d %Y')':}${clock}%{A}"

		sleep ${DATE_SLEEP}
	done
}

clock > "${PANEL_FIFO}" &

echo "" | lemonbar -p -g 1534x36+193+6 -B "${BBG}" -d -n "bg" &
sleep 0.2
echo "" | lemonbar -p -g 1524x26+198+11 -B "${BDR}" -d &

while read -r line; do
	case $line in
		CLOCK*)
			fn_time="${line#CLOCK }"
			;;
		VOLUME*)
			fn_vol="${line#VOLUME }"
			;;
		BRIGHTNESS*)
			fn_bright="${line#BRIGHTNESS }"
			;;
		BATTERY*)
			fn_bat="${line#BATTERY }"
			;;
		TITLE*)
			fn_title="${line#TITLE }"
			;;
		WORKSPACES*)
			fn_work="${line#WORKSPACES }"
			;;
		LAYOUT*)
			fn_layout="${line#LAYOUT }"
			;;
		WIRELESS*)
			fn_wire="${line#WIRELESS }"
			;;
	esac
	printf "%s\n" "%{l} ${fn_work}${SEP2}${fn_layout}%{c}${fn_title}%{r}${fn_vol}${SEP}${fn_bright}${SEP}${fn_bat}${SEP}${fn_wire}${SEP}${fn_time}  "
done < "${PANEL_FIFO}" | lemonbar ${OPTIONS} | sh > /dev/null
