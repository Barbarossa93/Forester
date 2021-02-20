#!/bin/sh

bluetooth_print() {
    bluetoothctl | while read -r; do
        if [ "$(sudo bluetooth | awk '{print $3}')" = "on" ]; then
            #printf ''
	    printf "%s" "%{F#89beba} %{F-}"

            devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
            counter=0

            echo "$devices_paired" | while read -r line; do
                device_info=$(bluetoothctl info "$line")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

                    if [ $counter -gt 0 ]; then
                        printf ", %s" "$device_alias"
                    else
                        printf "%s" "$device_alias"
                    fi

                    counter=$((counter + 1))
                fi

                printf '\n'
            done
        else
            #echo "%{F#9a998e}%{F-} Off"
            echo "%{F#868d80}%{F-} Off"
        fi
    done
}

bluetooth_toggle() {
	if [ "$(sudo bluetooth | awk '{print $3}')" = "off" ]; then
        sudo bluetooth on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        sudo bluetooth off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac

