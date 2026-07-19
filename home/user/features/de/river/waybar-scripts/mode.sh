#!/bin/sh

while :; do
	octl subscribe mode |
		jq -c --unbuffered \
			'{text: (if .mode == "normal" then "" else .mode end), class: .mode}'
	sleep 1 # reconnect loop: octl exits when the wm goes away
done
