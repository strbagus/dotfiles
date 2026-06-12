#!/usr/bin/env bash
WM=$1


CHOICE=$(printf "1. Logout\n2. Suspend\n3. Power Off\n4. Reboot\n5. Lockscreen" \
         | rofi -dmenu -p "Power option:" | awk '{print $1}' | tr -d '.')

[ -z "$CHOICE" ] && exit 0  # user cancelled

case "$CHOICE" in
	1)
		if [ "$WM" == "i3wm" ]; then
			i3-msg exit
		else
			swaymsg exit
		fi
		;;
	2)
		systemctl suspend
		;;
	3)
		systemctl poweroff
		;;
	4)
		systemctl reboot
		;;
	5)
		if [ "$WM" == "i3wm" ]; then
			light-locker-command -l
		else
			/home/strbagus/Others/scripts/swaylock.sh
		fi
		;;
	*)
			notify-send "Powermenu" "Not a valid option!"
		;;
esac
