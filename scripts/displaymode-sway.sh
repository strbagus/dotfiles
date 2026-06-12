#!/usr/bin/env bash
key=$1

# Adjust these names based on: swaymsg -t get_outputs
LAPTOP="eDP-1"
EXTERNAL=$(swaymsg -t get_outputs | jq -r '.[] | select(.name != "'$LAPTOP'") | .name' | head -n 1)

if [ -z "$EXTERNAL" ]; then
    notify-send "No external monitor detected, using laptop only."
    swaymsg output "$LAPTOP" enable position 0 0
    swaymsg output "$EXTERNAL" disable
    exit 0
fi


case "$key" in
  1)
    MODE="Mode 1: Laptop only"
    swaymsg output "$LAPTOP" enable position 0 0
    swaymsg output "$EXTERNAL" disable
    ;;
  2)
    MODE="Mode 2: Mirror Laptop + External ($EXTERNAL)"
    swaymsg output "$LAPTOP" enable position 0 0
    swaymsg output "$EXTERNAL" enable position 0 0
    ;;
  3)
    MODE="Mode 3: Extend (Laptop Left + External Right)"
    swaymsg output "$LAPTOP" enable position 0 0
    swaymsg output "$EXTERNAL" enable position 1920 0
    ;;
  4)
    MODE="Mode 4: Extend (Laptop Top + External Bottom)"
    swaymsg output "$LAPTOP" enable position 0 1080
    swaymsg output "$EXTERNAL" enable position 0 0
    ;;
  *)
    notify-send "Invalid mode. Use 1, 2, 3, or 4."
    exit 1
    ;;
esac

notify-send "$MODE"

