#!/usr/bin/env bash

# Terminate already running bar instances cleanly
killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done

echo "---" | tee -a /tmp/polybar.log
polybar bar 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
