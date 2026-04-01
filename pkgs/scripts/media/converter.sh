#!/usr/bin/env bash
# Convert a screen recording to GIF and muted WebM.
# Usage: converter.sh [--obs] [input-file]

set -euo pipefail

OUTPUT_DIR="$HOME/Videos/converted"
SEARCH_DIR="$HOME/Videos"

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --obs)
            SEARCH_DIR="$HOME/Videos/OBS"
            shift
            ;;
        *)
            INPUT="$1"
            shift
            ;;
    esac
done

# If no input file given, use fzf to pick one
if [ -z "${INPUT:-}" ]; then
    if [ ! -d "$SEARCH_DIR" ]; then
        echo "Error: $SEARCH_DIR does not exist"
        exit 1
    fi
    INPUT=$(find "$SEARCH_DIR" -maxdepth 1 -type f \( -name '*.mkv' -o -name '*.mp4' -o -name '*.webm' -o -name '*.avi' -o -name '*.mov' \) | sort -r | fzf --prompt="Select video: ")
    if [ -z "$INPUT" ]; then
        echo "No file selected"
        exit 1
    fi
fi

if [ ! -f "$INPUT" ]; then
    echo "Error: $INPUT not found"
    exit 1
fi

DEFAULT_NAME="$(basename "${INPUT%.*}")"
read -rp "Output name [$DEFAULT_NAME]: " NAME
NAME="${NAME:-$DEFAULT_NAME}"

mkdir -p "$OUTPUT_DIR"

echo "Generating GIF..."
ffmpeg -y -i "$INPUT" \
    -vf "fps=30,split[s0][s1];[s0]palettegen=stats_mode=full[p];[s1][p]paletteuse=dither=sierra2_4a" \
    "$OUTPUT_DIR/$NAME.gif"

echo "Generating muted WebM..."
ffmpeg -y -i "$INPUT" \
    -an \
    -c:v libvpx-vp9 -crf 30 -b:v 0 \
    "$OUTPUT_DIR/$NAME.webm"

echo "Done:"
ls -lh "$OUTPUT_DIR/$NAME.gif" "$OUTPUT_DIR/$NAME.webm"
