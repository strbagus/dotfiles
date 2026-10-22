#!/usr/bin/env bash

FILE="/sys/class/power_supply/BAT0/charge_control_end_threshold"
[ ! -f "$FILE" ] && FILE="/sys/class/power_supply/BAT0/charge_stop_threshold"

VAL="unknown"
[ -f "$FILE" ] && VAL=$(cat "$FILE" 2>/dev/null)

if [ "$1" = "--notify" ]; then
    if [ "$VAL" -le 85 ] 2>/dev/null; then
        notify-send "TLP Battery Limit" "Active: Desk Mode (80%)\nRun 'tlpf' in terminal for 100%"
    else
        notify-send "TLP Battery Limit" "Active: Full Mode (100%)\nRun 'tlps' in terminal for 80%"
    fi
    exit 0
fi

if [ "$VAL" -le 85 ] 2>/dev/null; then
    echo "󰚥"
elif [ "$VAL" -gt 85 ] 2>/dev/null; then
    echo "󱐋"
else
    echo ""
fi
