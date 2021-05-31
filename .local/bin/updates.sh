#!/bin/sh

export PATH="/home/barbarossa/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
export DISPLAY=":0"
export XAUTHORITY="/home/barbarossa/.Xauthority"
export XDG_RUNTIME_DIR="/run/user/1000"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(paru -Qua 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    #echo " $updates"
    notify-send -u normal -t 3000 " Updates: $updates"
else
    echo ""
fi

