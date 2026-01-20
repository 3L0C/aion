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
  title=$(playerctl --player="$player" metadata --format "{{title}}" 2>/dev/null | head -c 25)
  artist=$(playerctl --player="$player" metadata --format "{{artist}}" 2>/dev/null | head -c 15)
  if [[ -n "$artist" && -n "$title" ]]; then
    display="$artist - $title"
  elif [[ -n "$title" ]]; then
    display="$title"
  else
    display="(no media)"
  fi

  # Escape quotes in display text for JSON
  display=$(echo "$display" | sed 's/"/\\"/g')
  [[ "$status" == "Playing" ]] && icon="⏸" || icon="▶"

  # Build JSON object
  if [[ "$first" == "true" ]]; then
    first=false
  else
    result+=","
  fi
  result+="{\"player\":\"$player\",\"display\":\"$display\",\"status\":\"$status\",\"icon\":\"$icon\"}"
done <<< "$players"

result+="]"
echo "$result"
