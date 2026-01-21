#!/usr/bin/env bash

WM="$1"  # i3wm or sway

if [ -z "$WM" ]; then
    notify-send "Usage: ./displaymenu.sh {i3wm|sway}"
    exit 1
fi

case "$WM" in
    i3wm|sway)
        ;;
    *)
        notify-send "Invalid WM: $WM (use i3wm or sway)"
        exit 1
        ;;
esac

LAPTOP="eDP-1"
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name != "'$LAPTOP'") | .name' | head -n 1)

if [ -z "$EXTERNAL" ]; then
    notify-send "No external monitor detected, using laptop only."
    exit 0
fi

CHOICE=$(printf "1. Laptop only\n2. Mirror\n3. Extend (Laptop Left + External Right)\n4. Extend (Laptop Bottom + External Top)" \
    | rofi -dmenu -p "Display Mode:" | awk '{print $1}' | tr -d '.')

[ -z "$CHOICE" ] && exit 0

if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 4 ]; then
    notify-send "Not a valid option!"
    exit 0
fi

notify-send "Mode $CHOICE Selected."

DIR="$(dirname "$(readlink -f "$0")")"
"$DIR/displaymode-$WM.sh" "$CHOICE"
