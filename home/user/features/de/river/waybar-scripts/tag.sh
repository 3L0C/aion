#!/bin/sh

usage() {
	echo "usage: tag.sh [--show-empty] TAG [OUTPUT]" >&2
	exit 1
}

show_empty=false
tag=''
output=''
for arg in "$@"; do
	case $arg in
	--show-empty) show_empty=true ;;
	-*) usage ;;
	*)
		if [ -z "$tag" ]; then
			tag=$arg
		elif [ -z "$output" ]; then
			output=$arg
		else
			usage
		fi
		;;
	esac
done

case $tag in
'' | *[!0-9]*) usage ;;
esac

set --
if [ -n "$output" ]; then
	set -- --output "$output"
fi

while :; do
	octl subscribe tags "$@" |
		jq -c --unbuffered --argjson t "$tag" --argjson show "$show_empty" '
            { text: (if $show or (.viewed | index($t)) or (.occupied | index($t))
                     then ($t | tostring)
                     else ""
                     end)
            , class: [ (if (.focused  | index($t)) then "focused"  else empty end)
                     , (if (.urgent   | index($t)) then "urgent"   else empty end)
                     , (if (.viewed   | index($t)) then "viewed"   else empty end)
                     , (if (.occupied | index($t)) then "occupied" else empty end) ]
            }'
	sleep 1 # reconnect loop: octl exits when the wm goes away
done
