#!/bin/bash

lock() {
	i3lock -i ~/Pictures/lock_background2.jpg -t --datestr "Password:" --composite -c 323d43ff -n \
			--datecolor=d8caac --datepos='w/2+x:h/2-30' --date-font="spectrum berry" --datesize=11 \
		 	--wrong-font="spectrum berry" --verif-font="spectrum berry" --veriftext="verifying..." --wrongsize=11 \
			--verifsize=11 --verifcolor=87c095 --wrongcolor=e68183 --bar-indicator --bar-total-width 300 --bar-direction=1 \
			--bar-position='w/2-150+x:h/2+45' --bar-color=323d43 --bar-max-height=35 --bar-base-width=50 --bar-count=30 \
			--keyhlcolor=a7c080 --bshlcolor=e68183 --ringvercolor=323d43 --ringwrongcolor=323d43 --pass-media-keys \
			--pass-power-keys --pass-screen-keys --pass-volume-keys --greetertext "________________________________________" \
			--force-clock --timestr="" --greeterpos="w/2+x:h/2+50" --greeter-font="spectrum berry" --greetercolor=d8caac --greetersize=14
}

# Clear gpg-cache and ssh keys prior to lock. pam-gnupg starts it up again after unlock
gpg-connect-agent --no-autostart reloadagent /bye

# Clear all clipboard & selections
xclip -selection clipboard /dev/null
xclip -selection primary /dev/null
xclip -selection secondary /dev/null

#if lock fails, relock the screen
lock || lockscreen.sh

