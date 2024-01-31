#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib:/usr/local/XSGX/lib:/lib
#export DISPLAY=:0
export HOME=/userdata/system
export SDL_RENDER_DRIVER=opengles2
cd $HOME


BOOTCONF="/boot/batocera-boot.conf"
REBOOT_FLAG=/var/run/retroarch-launcher

if test "$1" = "--stop-rebooting"
then
    rm -f "${REBOOT_FLAG}"
    exit 0
fi

# flag to reboot at each stop
# es is stopped : in case of crash, in case of some options are changed (language, video mode)
touch "${REBOOT_FLAG}" || exit 1

# environment
export HOME=/userdata/system


CUSTOM_LAUNCHER_FILE="/boot/customlauncher"

LAUNCHER="emulationstation"

if [ -f "${CUSTOM_LAUNCHER_FILE}" ]; then
    # Read the content of the file
    LAUNCHER=$(cat "${CUSTOM_LAUNCHER_FILE}")
fi

GAMELAUNCH=1
while test -e "${REBOOT_FLAG}"
do
    if test "$LAUNCHER" = "retroarch"
    then
	cd $HOME
        taskset 8 retroarch --verbose
    else
	cd $HOME
	taskset 8 $LAUNCHER
    fi
    GAMELAUNCH=0
done
exit 0
