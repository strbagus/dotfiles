#!/usr/bin/env bash

# Kill existing Waybar instance
killall waybar 2>/dev/null

# Wait a bit to ensure it’s fully stopped
sleep 0.5

# Relaunch Waybar
echo "---" | tee -a /tmp/waybar.log
waybar 2>&1 | tee -a /tmp/waybar.log & disown

echo "Waybar launched..."
