#!/usr/bin/env bash
#xdotool getactivewindow windowmove 588 292 windowsize 736 491; 
urxvtdc -name "youtube" -g 107x36 -e bash -ic "YTFZF_ENABLE_FZF_DEFAULT_OPTS=1 ytfzf -t"
