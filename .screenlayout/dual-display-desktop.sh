#!/bin/sh
xrandr --output DVI-I-1 --off --output DP-2 --mode 1920x1200 --pos 1920x0 \
       --rotate right --output DP-1 --primary --mode 1920x1200 --pos 0x440 --rotate normal
