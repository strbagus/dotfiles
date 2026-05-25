#!/bin/bash

STATE_FILE="/tmp/screen_sleep_state"
DEFAULT_TIMEOUT=600 # 10 minutes

if [ ! -f "$STATE_FILE" ]; then
    echo "standard" > "$STATE_FILE"
fi

CURRENT_STATE=$(cat "$STATE_FILE")

if [ "$1" == "check" ]; then
    if [ "$CURRENT_STATE" == "awake" ]; then
        echo "%{F#ff9d4d}󰛊%{F-}"
    else
        echo "%{F#ffffff}󰛊%{F-}"
    fi
else
    if [ "$CURRENT_STATE" == "standard" ]; then
        xset s off -dpms 
        echo "awake" > "$STATE_FILE"
        notify-send -u low "Screen" "Caffeine Active: Screen staying awake"
    else
        xset s on +dpms
        xset s $DEFAULT_TIMEOUT $DEFAULT_TIMEOUT
        xset dpms $DEFAULT_TIMEOUT $DEFAULT_TIMEOUT $DEFAULT_TIMEOUT
        echo "standard" > "$STATE_FILE"
        notify-send -u low "Screen" "Standard Mode: 10m sleep enabled"
    fi
fi
