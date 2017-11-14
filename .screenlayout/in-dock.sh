#!/bin/sh

xrandr --output VGA-0 --off \
       --output DP-6 --off \
       --output DP-5 --off \
       --output DP-4 --primary --mode 1920x1200 --pos 1920x360 --rotate normal \
       --output DP-3 --mode 1920x1080 --pos 0x360 --rotate normal \
       --output DP-2 --mode 1920x1200 --pos 3840x0 --rotate left \
       --output DP-1 --off --output DP-0 --off
