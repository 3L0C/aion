#!/usr/bin/env bash

players=$(playerctl --list-all 2>/dev/null)
if [[ -z "$players" ]]; then
    echo "[]"
    exit 0
fi

result="["
first=true

while read -r player; do
    [[ -z "$player" ]] && continue

    status=$(playerctl --player="$player" status 2>/dev/null || echo "Stopped")
    title=$(playerctl --player="$player" metadata --format "{{title}}" 2>/dev/null | head -c 30)

    # Format display text - just title
    if [[ -n "$title" ]]; then
        display="$title"
    else
        display="(no media)"
    fi

    # Escape quotes in display text for JSON
    display=$(echo "$display" | sed 's/"/\\"/g')

    # Status icon: || for playing (click to pause), > for paused (click to play)
    [[ "$status" == "Playing" ]] && icon="󰏤" || icon="󰐊"

    # Build JSON object
    if [[ "$first" == "true" ]]; then
        first=false
    else
        result+=","
    fi
    result+="{\"player\":\"$player\",\"display\":\"$display\",\"status\":\"$status\",\"icon\":\"$icon\"}"
done <<<"$players"

result+="]"
echo "$result"
