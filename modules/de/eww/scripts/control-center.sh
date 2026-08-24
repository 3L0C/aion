#!/usr/bin/env bash
# Output JSON state for eww control center
# Returns: {"volume": 50, "muted": false, "backlight": 70}

# Get volume and mute status from pamixer
volume=$(pamixer --get-volume 2>/dev/null || echo "0")
muted=$(pamixer --get-mute 2>/dev/null || echo "false")

# Get backlight percentage from brightnessctl (null if no backlight device)
if command -v brightnessctl &>/dev/null && brightnessctl -l 2>/dev/null | grep -q "intel_backlight"; then
    backlight=$(brightnessctl --device=intel_backlight -m | cut -d',' -f4 | tr -d '%')
else
    backlight="null"
fi

# Output JSON
if [[ "$backlight" == "null" ]]; then
    echo "{\"volume\": $volume, \"muted\": $muted, \"backlight\": null}"
else
    echo "{\"volume\": $volume, \"muted\": $muted, \"backlight\": $backlight}"
fi
