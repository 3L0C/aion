#!/bin/sh

while :; do
	octl subscribe focus |
		jq -c --unbuffered '{text: (.title // "")}'
	sleep 1 # reconnect loop: octl exits when the wm goes away
done
