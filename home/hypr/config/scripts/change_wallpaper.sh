#!/usr/bin/env bash

set -e

# Check if a wallpaper path was provided

if [ $# -ne 1 ]; then
  echo "Usage: $0 /path/to/wallpaper"
  exit 1
fi

WALLPAPER="$1"

# Verify file exists

if [ ! -f "$WALLPAPER" ]; then
  echo "Error: File not found: $WALLPAPER"
  exit 1
fi

echo "Setting wallpaper: $WALLPAPER"

# Generate pywal colors
wal -i "$WALLPAPER" -n

# Set awww wallpaper
awww img "$WALLPAPER" -t center

# Restart Wayle panel
wayle panel restart

echo "Done."
