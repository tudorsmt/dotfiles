#!/usr/bin/env bash

DISPLAY_NUMBER=$(xrandr | grep " connected" -c)

case "${DISPLAY_NUMBER}" in
    "3")
        echo "3 displays detected, deploying settings"
        ~/.screenlayout/in-dock.sh
        ;;
    "2")
        echo "2 displays detected, deploying settings"
        ~/.screenlayout/dual-display-desktop.sh
        ;;
    *)
        echo "Detected ${DISPLAY_NUMBER}, doing nothing"
        ;;
esac
