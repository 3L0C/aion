#!/bin/sh
# capture.sh [OUTPUT] [sep]
#
# capture.sh feeds the waybar custom/capture module.
#
# Streams `oxctl subscribe output` (for OUTPUT when given) and emits "REC"
# with the `recording` class while the output has a capture session, empty
# text otherwise. With the second argument `sep`, it emits "|" instead of
# "REC", which feeds the custom/capture-sep module.

output=${1-}
text=REC
[ "${2-}" = sep ] && text='|'
set --
if [ -n "$output" ]; then
	set -- --output "$output"
fi

while :; do
	oxctl subscribe output "$@" |
		jq -c --unbuffered --arg text "$text" \
			'{text: (if .captured then $text else "" end)
            , class: (if .captured then "recording" else "" end)}'
	sleep 1 # reconnect loop: oxctl exits when the wm goes away
done
