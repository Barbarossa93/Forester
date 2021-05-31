#!/usr/bin/env bash
set -euo pipefail

day_of_week=$(date "+%u")
current_hour=$(date "+%H")

if [ "$day_of_week" -ne 7 ] && [ "$day_of_week" -ne 6 ]; then
    if [ $current_hour -ge 9 ] && [ $current_hour -le 16 ]; then
        /usr/bin/qutebrowser --nowindow ':set content.blocking.method both ;; set content.blocking.hosts.lists ["file://home/barbarossa/.config/qutebrowser/host_block"] ;; adblock-update ;; message-info "Distraction free mode enabled"'
    else
        /usr/bin/qutebrowser --nowindow ':set content.blocking.method auto ;; adblock-update ;; message-info "Distraction free mode disabled"'
    fi 
    else
        /usr/bin/qutebrowser --nowindow ':set content.blocking.method auto ;; adblock-update ;; message-info "Distraction free mode disabled"'
fi
