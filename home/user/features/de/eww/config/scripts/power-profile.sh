#!/usr/bin/env bash
# Output current power profile for eww control center (ASUS laptops)
# Returns: "Quiet", "Balanced", or "Performance"

asusctl profile -p 2>/dev/null | grep -oE 'Quiet|Balanced|Performance' || echo "Unknown"
