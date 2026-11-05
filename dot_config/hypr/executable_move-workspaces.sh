#!/bin/bash

MAIN_MONITOR="DP-1"

hyprctl workspaces -j |
    jq -r --arg monitor "$MAIN_MONITOR" \
        '.[] | select(.monitor != $monitor) | .id' |
    while read -r WS; do
        hyprctl eval "hl.dispatch(hl.dsp.workspace.move({ workspace = $WS, monitor = \"$MAIN_MONITOR\" }))"
        sleep 0.05
    done
