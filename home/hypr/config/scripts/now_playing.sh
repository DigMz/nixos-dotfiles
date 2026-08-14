#!/usr/bin/env bash

MAX_CHARS=40

status="$(playerctl status 2>/dev/null)" || exit 0

case "$status" in
    Playing|Paused)
        ;;
    *)
        exit 0
        ;;
esac

title="$(playerctl metadata --format '{{ title }}' 2>/dev/null)"
artist="$(playerctl metadata --format '{{ artist }}' 2>/dev/null)"

[ -n "$title" ] || exit 0

if [ -n "$artist" ]; then
    text="$title - $artist"
else
    text="$title"
fi

if [ "${#text}" -gt "$MAX_CHARS" ]; then
    text="${text:0:$((MAX_CHARS - 1))}…"
fi

text="$text     "

len=${#text}
pos=$(( $(date +%s) % len ))

printf '♪  %s\n' "${text:$pos}${text:0:$pos}"
