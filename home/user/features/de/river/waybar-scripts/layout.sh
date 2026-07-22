#!/bin/sh

output=${1-}
set --
if [ -n "$output" ]; then
	set -- --output "$output"
fi

while :; do
	octl subscribe layout "$@" |
		jq -c --unbuffered '
            { text: .symbol
            , tooltip: (if .scheme
                        then "\(.layout) \(.scheme)"
                        else .layout end)
            }'
	sleep 1 # reconnect loop: octl exits when the wm goes away
done
