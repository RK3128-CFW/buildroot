#!/bin/sh

export SDL_NOMOUSE=1

echo "Launching $1 $2"

eval $1 \"$2\" &

while true
do
        sleep 2
        ra_pid=$(busybox pidof retroarch)
        echo "RAPID: " $ra_pid
        if [[ -z $ra_pid ]]; then
                echo "RA ended returning to simplermenu+"
                sleep 1
                echo "U:480x273p-0" > /sys/devices/platform/display-subsystem/graphics/fb0/mode
                simplermenu_plus &
                exit
        fi
done


