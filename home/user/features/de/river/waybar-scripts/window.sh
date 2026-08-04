#!/bin/sh

output=${1-}
set --
if [ -n "$output" ]; then
	set -- --output "$output"
fi

while :; do
	oxctl subscribe window "$@" |
		jq -c --unbuffered \
			'{text: (.title // ""), class: (if .focused then "focused" else "" end)}'
	sleep 1 # reconnect loop: oxctl exits when the wm goes away
done
