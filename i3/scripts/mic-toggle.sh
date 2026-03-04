#!/bin/bash

# Toggle mic
pactl set-source-mute @DEFAULT_SOURCE@ toggle

# Get current mute state (yes/no)
STATE=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')


# Sync ThinkPad mic LED
if [ "$STATE" = "yes" ]; then
    echo 1 > /sys/class/leds/platform::micmute/brightness
else
    echo 0 > /sys/class/leds/platform::micmute/brightness
fi

# Refresh i3status (same as your current config)
if [ -n "$refresh_i3status" ]; then
    eval "$refresh_i3status"
fi
