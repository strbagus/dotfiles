#!/bin/bash

while true; do
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
    STATE=$(cat /sys/class/power_supply/BAT0/status)

    if [ "$BATTERY_LEVEL" -le 15 ] && [ "$STATE" = "Discharging" ]; then
        notify-send -u critical "Battery Low" "Level: $BATTERY_LEVEL%" -i battery-caution
        sleep 300
    fi
    sleep 60
done
