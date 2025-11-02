#!/usr/bin/env bash

layout="$(hyprctl getoption "general:layout" | sed -E '/str/!d;s/str:\s+//')"

case "$layout" in
    master) echo "[]=" ;;
    dwindle) echo "[\]" ;;
    *) echo "[?]" ;;
esac
