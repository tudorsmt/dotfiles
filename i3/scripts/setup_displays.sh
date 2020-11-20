#!/usr/bin/env bash

DISPLAY_NUMBER=$(xrandr | grep " connected" -c)

host=$(hostname)

host_script="${HOME}/.screenlayout/${host}-${DISPLAY_NUMBER}.sh"

if [ -e "${host_script}" ]; then
    echo "Executing ${host_script} in 5s"
    sleep 5
    "${host_script}" && exit 0
else
    case "${DISPLAY_NUMBER}" in
        "3")
            echo "3 displays detected, deploying settings in 5 seconds"
            sleep 5
            ~/.screenlayout/in-dock.sh
            ;;
        "2")
            echo "2 displays detected, deploying settings in 5 seconds"
            sleep 5
            ~/.screenlayout/dual-display-desktop.sh
            ;;
        *)
            echo "Detected ${DISPLAY_NUMBER}, doing nothing"
            ;;
    esac
fi
