#!/bin/sh

name='Master'

value=$(amixer sget "$name" | sed -n "s/  Front Left: Playback \([0-9]*\) .*/\1/p")

if [[ "$1" == "up" ]]; then
        let value=value+2
        if [[ $value -gt 30 ]]; then value=30; fi
else
        let value=value-2
        if [[ $value -lt 0 ]]; then value=0; fi
fi

amixer sset "$name" $value

