#!/usr/bin/env bash

PRESET_DIR=~/.screenlayout

cd "${PRESET_DIR}"
display_script=$(find . -maxdepth 1 -type f -name "*.sh" -printf "%f\\n" | rofi -dmenu)

if [ -n "${display_script}" ]; then
    echo "Display sccript non empty, will run $display_script"
    "${PRESET_DIR}/${display_script}"
else
    echo "Display sccript empty, will skip execution"
fi
