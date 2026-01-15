#!/usr/bin/env bash

LAPTOP="eDP-1"
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name != "'$LAPTOP'") | .name' | head -n 1)

if [ -z "$EXTERNAL" ]; then
    notify-send "No external monitor detected, using laptop only."
    exit 0
fi


CHOICE=$(printf "1. Laptop only\n2. Mirror\n3. Extend (Laptop Left + External Right)\n4. Extend (Laptop Bottom + External Top)" \
         | rofi -dmenu -p "Display Mode:" | awk '{print $1}' | tr -d '.')

[ -z "$CHOICE" ] && exit 0  # user cancelled

if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 4 ]; then
	notify-send "Not a valid option!"
    exit 0
fi

notify-send "Mode $CHOICE Selected."
DIR="$(dirname "$(readlink -f "$0")")"
"$DIR/displaymode-sway.sh" "$CHOICE"
