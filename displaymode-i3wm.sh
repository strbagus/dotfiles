#!/usr/bin/env bash
key=$1

LAPTOP="eDP-1"
RESOLUTION="1920x1080"
EXTERNAL=$(xrandr | awk '/ connected/ && $1 != "'"$LAPTOP"'" {print $1; exit}')

if [ -z "$EXTERNAL" ]; then
    notify-send "No external monitor detected, using laptop only."
    OTHER_OUTPUT_ARGS=""
    ALL_OUTPUTS=$(xrandr --query | grep -E ' (connected|disconnected)' | awk '{print $1}')
    for out in $ALL_OUTPUTS; do
        if [ "$out" != "$LAPTOP" ]; then
            OTHER_OUTPUT_ARGS="$OTHER_OUTPUT_ARGS --output $out --off"
        fi
    done
    xrandr --output "$LAPTOP" --mode "$RESOLUTION" --primary $OTHER_OUTPUT_ARGS
    exit 0
fi

case "$key" in
  1)
    MODE="Mode 1: Laptop only"
    xrandr \
      --output "$LAPTOP" --mode "$RESOLUTION" --primary \
      --output "$EXTERNAL" --off
    ;;
  2)
    MODE="Mode 2: Mirror Laptop + External ($EXTERNAL)"
    xrandr \
      --output "$LAPTOP" --mode "$RESOLUTION" --primary \
      --output "$EXTERNAL" --mode "$RESOLUTION" --same-as "$LAPTOP"
    ;;
  3)
    MODE="Mode 3: Extend (Laptop Left + External Right, $EXTERNAL)"
    xrandr \
      --output "$LAPTOP" --mode "$RESOLUTION" --primary --pos 0x0 \
      --output "$EXTERNAL" --mode "$RESOLUTION" --right-of "$LAPTOP"
    ;;
  4)
    MODE="Mode 4: Extend (Laptop Bottom + External Top, $EXTERNAL)"
    xrandr \
      --output "$LAPTOP" --mode "$RESOLUTION" --primary --pos 0x0 \
      --output "$EXTERNAL" --mode "$RESOLUTION" --above "$LAPTOP"
    ;;
  *)
    echo $MODE
    ;;
esac

notify-send "$MODE"
