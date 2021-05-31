#!/usr/bin/env bash

# Place config files here to edit
declare -a files
files=(
	#~/.config/termite/config
	~/Public/neat-things/colorschemes/forest-night-xresources/forest-night
	#~/.config/polybar/polybar-scripts/hlwm-workspaces.sh
	#~/.config/polybar/polybar-scripts/hlwm_layout.sh
	~/.config/dunst/dunstrc
	~/.config/zathura/colourtheme.conf
	#~/.mozilla/firefox/1ag6x5tq.barbarossa/chrome/userChrome.css
	#~/.mozilla/firefox/1ag6x5tq.barbarossa/chrome/userContent.css
	#~/.mozilla/firefox/1ag6x5tq.barbarossa/startpage/index.html
	~/.config/herbstluftwm/autostart
	~/.tmux/myrmidontmux
	~/.tmux.conf.local
	~/.config/xob/styles.cfg
	~/.config/qutebrowser/everforest/draw.py
	~/.config/qutebrowser/startpage/index.html 
	~/.config/qt5ct/qss/custom-tooltip.qss
	~/.config/qt5ct/qss/custom-context-menu.qss
	~/Public/neat-things/colorschemes/forest-night-xresources/forest-night.sh
)

#dark to light theme
dtl() {
	#light=true
	for i in "${files[@]}"; do
		echo "$i"
		sed -i 's/#d3c6aa/#5c6a72/g' "$i"
		sed -i 's/#323d43/#f8f0dc/g' "$i"
		sed -i 's/#3c474d/#efead4/g' "$i"
		sed -i 's/#868d80/#999f93/g' "$i"
		sed -i 's/#e67e80/#f85552/g' "$i"
		sed -i 's/#a7c080/#8da101/g' "$i"
		sed -i 's/#dbbc7f/#dfa000/g' "$i"
		sed -i 's/#7fbbb3/#3a94c5/g' "$i"
		sed -i 's/#d699b6/#df69ba/g' "$i"
		sed -i 's/#83c092/#35a77c/g' "$i"
		sed -i 's/#e69875/#f57d26/g' "$i"
	done
	sed -i 's/set background=dark/set background=light/g' ~/.config/nvim/init.vim
	#sed -i "28s/.*/(setq doom-theme 'doom-everforest-light)/" ~/.doom.d/config.el
	sed -i "s/c.colors.webpage.darkmode.enabled = True/c.colors.webpage.darkmode.enabled = False/g" ~/.config/qutebrowser/config.py
	#sed -i "s/colors: \*everforest_dark_soft/colors: \*everforest_light_soft/g" ~/.config/alacritty/alacritty.yml 
	paleta < ~/Public/neat-things/colorschemes/forest-night-xresources/everforest-light.pal
	gtk_theme="Net/ThemeName \"everforest_light\"" #\nNet/CursorThemeName \"pixelfun3\""
}

#light to dark theme
ltd() {
	#light=false
	for i in "${files[@]}"; do
		echo "$i"
		sed -i 's/#5c6a72/#d3c6aa/g' "$i"
		sed -i 's/#f8f0dc/#323d43/g' "$i"
		sed -i 's/#efead4/#3c474d/g' "$i"
		sed -i 's/#999f93/#868d80/g' "$i"
		sed -i 's/#f85552/#e67e80/g' "$i"
		sed -i 's/#8da101/#a7c080/g' "$i"
		sed -i 's/#dfa000/#dbbc7f/g' "$i"
		sed -i 's/#3a94c5/#7fbbb3/g' "$i"
		sed -i 's/#df69ba/#d699b6/g' "$i"
		sed -i 's/#35a77c/#83c092/g' "$i"
		sed -i 's/#f57d26/#e69875/g' "$i"
	done
	sed -i 's/set background=light/set background=dark/g' ~/.config/nvim/init.vim
	#sed -i "28s/.*/(setq doom-theme 'doom-everforest)/g" ~/.doom.d/config.el
	sed -i "s/c.colors.webpage.darkmode.enabled = False/c.colors.webpage.darkmode.enabled = True/g" ~/.config/qutebrowser/config.py	
	#sed -i "s/colors: \*everforest_light_soft/colors: \*everforest_dark_soft/g" ~/.config/alacritty/alacritty.yml 
	paleta < ~/Public/neat-things/colorschemes/forest-night-xresources/everforest-dark.pal
	gtk_theme="Net/ThemeName \"everforest_dark\"" #\nNet/CursorThemeName \"pixelfun3-eclipse\""
}

mouse() {
	# Load mouse theme on startup. Unfortunately, I can't live reload a mouse completely in a running X session
	time_vars
	#corrected_sunset="$corrected_hour:$sunset_minute"
	unix_now=$(date +%s)
	unix_sunrise=$(date --date="$sunrise" +%s)
	unix_sunset=$(date --date="$sunset" +%s)
	unix_sunrise_next=$(( unix_sunrise + 86400 ))
	if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -lt "$unix_sunset" ]; then
		sed -i '5s/.*/gtk-cursor-theme-name=pixelfun3/' ~/.config/gtk-3.0/settings.ini
		sed -i '5s/.*/Inherits=pixelfun3/' ~/.icons/default/index.theme
	elif [ "$unix_now" -ge "$unix_sunset" ] && [ "$unix_now" -lt "$unix_sunrise_next" ]; then	
		sed -i '5s/.*/gtk-cursor-theme-name=pixelfun3-eclipse/' ~/.config/gtk-3.0/settings.ini
		sed -i '5s/.*/Inherits=pixelfun3-eclipse/' ~/.icons/default/index.theme
	else
		echo "No switch needed."
	fi
}

reload() {
	xrdb ~/.Xresources
	#polybar-msg cmd restart
	#killall -USR1 st
	killall lemonbar && bar.sh &
	pkill dunst && dunst &
	#if $light; then
	#	emacsclient --eval "(load-theme 'doom-everforest-light)"
	#else
	#	emacsclient --eval "(load-theme 'doom-everforest)"
	#fi
	nvim-reload.py &
	tmux source-file ~/.tmux.conf
	if pgrep qutebrowser; then
		#qutebrowser ':config-source'
		qutebrowser ':restart'
	fi
	pkill xsettingsd
	xsettingsd -c <(echo -e "$gtk_theme") &
	pkill xob
	xob_startup.sh
	herbstclient reload
	disown -a
	## Doesn't reload or could be done better
	# zathura Have to manually source it in window
	# dunst; have to kill it first
	# firefox; same as dunst
	# xob; ^^^
}

time_vars() {
	## Dyn-wall-rs needs this set of vars
	#schedule=$(dyn-wall-rs -d Public/BitForest/ --lat 39.2908816 --long -76.610759 -s | grep "01")
	#sunrise_hour=$(echo "$schedule" | head -n1 | awk '{print $4}' | cut -d':' -f1)	
	#sunrise_minute=$(echo "$schedule" | head -n1 | awk '{print $4}' | cut -d':' -f2)
	#sunset_hour=$(echo "$schedule" | tail -n1 | awk '{print $4}' | cut -d':' -f1)
	#sunset_minute=$(echo "$schedule" | tail -n1 | awk '{print $4}' | cut -d':' -f2)
	#corrected_hour=$(( 12 + sunset_hour ))

	## Sunpaper vars
	schedule=$(sunpaper.sh -r)
	sunrise=$(echo "$schedule" | grep "2.jpg" | awk '{print $1}')
	sunset=$(echo "$schedule" | grep "1.jpg" | awk '{print $1}')

}

cron_setup() {
	# For dyn-wall-rs
	time_vars
	crontab -l > /tmp/cronlist
	sed -i '/theme_switcher.sh/d' /tmp/cronlist
	# sunrise cronjob
	echo "$sunrise_minute $sunrise_hour * * * /home/barbarossa/.local/bin/theme_switcher.sh -l" >> /tmp/cronlist
	# Sunset cronjob
	echo "$sunset_minute $corrected_hour * * * /home/barbarossa/.local/bin/theme_switcher.sh -d" >> /tmp/cronlist
	crontab /tmp/cronlist && rm /tmp/cronlist
}

main() {
	time_vars
	corrected_sunset="$corrected_hour:$sunset_minute"
	unix_now=$(date +%s)
	unix_sunrise=$(date --date="$sunrise" +%s)
	unix_sunset=$(date --date="$corrected_sunset" +%s)
	unix_sunrise_next=$(( unix_sunrise + 86400 ))
	if [ "$unix_now" -ge "$unix_sunrise" ] && [ "$unix_now" -lt "$unix_sunset" ]; then
		dtl
		reload
	elif [ "$unix_now" -ge "$unix_sunset" ] && [ "$unix_now" -lt "$unix_sunrise_next" ]; then
		ltd
		reload
	else
		echo "No switch needed."
	fi
}

while test $# -gt 0; do
	case "$1" in
		--cron|-c)
			cron_setup
			shift
			;;
		--switch|-s)
			main
			shift
			;;
		--light|-l)
			dtl
			reload
			shift
			;;
		--dark|-d)
			ltd
			reload
			shift
			;;
		--mouse|-m)
			mouse
			shift
			;;
		*)
			break
			;;
	esac
done
