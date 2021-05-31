#!/usr/bin/env bash

# sigma needed instead of radius for shadow part of first convert command e.g. -shadow OpacityxSigma+x+y
# Convert radius to sigma= r * 0.57735 + 0.5

sunpaperDir="$HOME/Public/BitForest_sunpaper"

if [ ! -d "$HOME/.cache/i3lock" ]; then
				mkdir -p $HOME/.cache/i3lock
fi

for file in $sunpaperDir/*; do
				echo $file
				name=$(basename $file .jpg)
				if [ "$name" == "1" ] || [ "$name" == "2" ] || [ "$name" == "8" ]; then
								bg="#323d43"
								bdr="#a7c080"
				else
								bg="#f8f0dc"
								bdr="#8da101"
				fi
				convert -size 410x182 xc:"$bg" /tmp/rec.png
				convert /tmp/rec.png \( -clone 0 -background "#000000" -shadow 70x7.4282+0+4 \) +swap -background none -layers merge +repage /tmp/shadow.png
				composite -gravity center /tmp/shadow.png $file /tmp/shadow_box.png
				magick /tmp/shadow_box.png -fill "$bdr" -draw "rectangle 765,455 1155,617" /tmp/inner_border.png
				magick /tmp/inner_border.png -fill "$bg" -draw "rectangle 767,457 1153,615" $HOME/.cache/i3lock/$name.jpg
done
