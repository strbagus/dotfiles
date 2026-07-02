#!/usr/bin/env bash

WM="$1"  # i3wm or sway

if [ -z "$WM" ]; then
    notify-send "Display Mode" "Usage: ./displaymenu.sh {expect: i3wm}"
    exit 1
fi

case "$WM" in
    i3wm|sway)
        ;;
    *)
        notify-send "Display Mode" "Invalid WM: $WM (use i3wm)"
        exit 1
        ;;
esac

LAPTOP="eDP-1"
EXTERNAL=$(xrandr --query | grep " connected" | awk '{print $1}' | grep -v "^$LAPTOP$" | head -n 1)
DIR="$(dirname "$(readlink -f "$0")")"

if [ -z "$EXTERNAL" ]; then
		"$DIR/displaymode-$WM.sh" 1
    exit 0
fi

CHOICE=$(printf "1. Laptop only\n2. Mirror\n3. Extend (Laptop Left + External Right)\n4. Extend (Laptop Bottom + External Top)\n5. External Only" \
    | rofi -dmenu -p "Display Mode:" | awk '{print $1}' | tr -d '.')

[ -z "$CHOICE" ] && exit 0

if [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt 5 ]; then
    notif-send "Not a valid option!"
    exit 0
fi

notify-send "Display Mode" "Mode $CHOICE Selected."


"$DIR/displaymode-$WM.sh" "$CHOICE"
