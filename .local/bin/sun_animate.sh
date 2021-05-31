#!/usr/bin/env bash

wallpaperPath="/home/barbarossa/Public/BitForest_sunpaper"
cachePath="/home/barbarossa/.cache/sunpaper"

cache_transitions() {
	for i in {1..8}; do
		if [ ! -d $cachePath/$i ]; then
			mkdir $cachePath/$i
		fi

		alpha=0
		c=0
		if [ $i -eq 1 ]; then
			while [ $alpha -le 100 ]; do
				alpha=$(( alpha + 5 ))
				c=$(( c + 1 ))
				composite -blend $alpha -gravity center $wallpaperPath/$i.jpg $wallpaperPath/8.jpg $cachePath/$i/$c.png
			done
			continue
		fi

		next=$(( $i - 1 ))
		while [ $alpha -le 100 ]; do
			alpha=$(( alpha + 5 ))
			c=$(( c + 1 ))
			composite -blend $alpha -gravity center $wallpaperPath/$i.jpg $wallpaperPath/$next.jpg $cachePath/$i/$c.png
		done
	done
}

animate_wallpaper(){
	directory="$1"
	files=$(ls -1 $cachePath/$directory | wc -l)
	for i in $(seq $files); do
		hsetroot -fill $cachePath/$directory/$i.png &
		sleep 0.05
	done
}

while :; do
	case "$1" in
		--cache|-c)
			cache_transitions
			shift
			;;
		--apply|-a)
			animate_wallpaper "$2"
			shift
			;;
		*)
			break
			;;
	esac
done
