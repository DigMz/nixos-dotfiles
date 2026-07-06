PID=$(hyprctl clients -j | jq -r '.[] | select(.class=="kitty-bg") | .pid')
if [[ -n "$PID" && "$PID" != "null" ]]; then
  echo "$PID"
  kill $PID
else
  $(kitty -o linux_display_server=x11 -o background_opacity=0 --class=kitty-bg cava)
  echo background
fi
