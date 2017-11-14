#!/usr/bin/env bash

if [ "$(xrandr | grep " connected" -c)" = "3" ]; then
    echo "3 displays detected, deplying settings"
    ~/.screenlayout/in-dock.sh
else
    echo "Haven't detected 3 displays, doing nothing"
fi
