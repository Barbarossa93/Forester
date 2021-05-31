#!/usr/bin/env bash
set -euo pipefail

if pidof redshift; then
    pkill redshift
    notify-send -u normal -a Redshift -t 3000 "Redshift disabled"
else
    redshift & 
    if pidof intel-virtual-output; then
        DISPLAY=:8 redshift &
    fi
    notify-send -u normal -a Redshift -t 3000 "Redshift enabled"
fi
