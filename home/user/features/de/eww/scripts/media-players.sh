#!/usr/bin/env bash
# Output JSON array of all active MPRIS players for eww media panel.
#
# Rows are emitted in state priority order (Playing first, then Paused,
# then Stopped) so the panel ordering matches the waybar custom/mpris
# module's selection logic. Within each bucket, playerctl --list-all
# order (playerctld LRU when the daemon is running) is preserved.

players=$(playerctl --list-all 2>/dev/null)
if [[ -z "$players" ]]; then
    echo "[]"
    exit 0
fi

# Partition players by playback state
playing=()
paused=()
stopped=()

while IFS= read -r player; do
    [[ -z "$player" ]] && continue
    status=$(playerctl --player="$player" status 2>/dev/null || echo "Stopped")
    case "$status" in
        Playing) playing+=("$player|$status") ;;
        Paused)  paused+=("$player|$status") ;;
        *)       stopped+=("$player|$status") ;;
    esac
done <<<"$players"

ordered=("${playing[@]}" "${paused[@]}" "${stopped[@]}")

result="["
first=true

for entry in "${ordered[@]}"; do
    player="${entry%%|*}"
    status="${entry#*|}"

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
done

result+="]"
echo "$result"
