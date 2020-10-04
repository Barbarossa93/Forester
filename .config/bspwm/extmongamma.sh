#!/bin/sh

export PATH="/home/barbarossa/.local/bin:/home/barbarossa/.local/bin:/sbin:/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

nextevent=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight NextEvent | awk '{print $2}')
sunrise=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Sunrise | awk '{print $2}')
sunset=$(busctl --user get-property org.clight.clight /org/clight/clight org.clight.clight Sunset | awk '{print $2}')
time=$(date +%s)

on() {
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.97107439:0.94305985 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.93853986:0.88130458 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.90198230:0.81465502 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.86860704:0.73688797 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.82854786:0.64816570 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.77987699:0.54642268 &> /dev/null
}

off() {
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.82854786:0.64816570 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.86860704:0.73688797 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.90198230:0.81465502 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.93853986:0.88130458 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1.00000000:0.97107439:0.94305985 &> /dev/null
	sleep 1
	DISPLAY=:8 xrandr --output HDMI-0 --gamma 1:1:1 &> /dev/null
}

if [[ "$nextevent" == "0" ]]; then
	if [ $time -ge $sunrise ]; then
		busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 6500 true 50 300
	fi
elif [[ "$nextevent" == "1" ]]; then
	if [ $time -ge $sunset ]; then
		busctl call org.clightd.clightd /org/clightd/clightd/Gamma org.clightd.clightd.Gamma Set "ssi(buu)" :8 $XAUTHORITY 4000 true 50 300
	fi
fi
