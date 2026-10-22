#!/usr/bin/env bash

# Prevent duplicate instances
if pidof -o %PPID -x "$(basename "$0")" >/dev/null 2>&1; then
    exit 0
fi

# Listen to i3 window events and notify via dunst when urgency flag is set
i3-msg -t subscribe -m '[ "window" ]' | while read -r line; do
    change=$(echo "$line" | jq -r '.change // empty' 2>/dev/null)
    if [ "$change" = "urgent" ]; then
        urgent_state=$(echo "$line" | jq -r '.container.urgent // empty' 2>/dev/null)
        # Only notify when window becomes urgent (not when cleared)
        if [ "$urgent_state" = "true" ]; then
            name=$(echo "$line" | jq -r '.container.name // "Terminal"' 2>/dev/null)
            notify-send -u normal -a "Antigravity" "Task Finished" "${name}"
        fi
    fi
done
