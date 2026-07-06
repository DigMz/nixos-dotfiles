#!/usr/bin/env bash

input_file="${HOME}/.cache/wal/colors-hyprland.conf"

if [[ -z "$input_file" ]]; then
  echo "Usage: $0 <input-file>"
  exit 1
fi

echo "local colors = {}"

while IFS= read -r line; do
  # Skip blank lines
  [[ -z "$line" ]] && continue

  if [[ "$line" =~ ^\$([A-Za-z0-9_]+)[[:space:]]*=[[:space:]]*(.+)$ ]]; then
    var="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"

    # Escape quotes in value if necessary
    value="${value//\"/\\\"}"

    echo "colors.${var} = \"${value}\""
  fi
done <"$input_file"

echo "return colors"
