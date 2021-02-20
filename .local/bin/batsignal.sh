#!/usr/bin/env bash

batsignal -w 12 -c 8 -d 5 -f 99 -W $'Warning!\nBattery Low' -C $'Alert!\nBattery Critical' -F $'Battery Full\nPlease disconect power supply' -D "poweroff" -e
