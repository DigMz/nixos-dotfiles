CLIENT=$(
  hyprctl clients -j | jq -r '
    .[]
    | select(.class == "bg-widget" and .initialTitle == "cava")
    | .pid
  '
)

echo $CLIENT

if [[ -n "$CLIENT" ]]; then
  kill $CLIENT
else
  hyprpm reload
  hyprctl dispatch exec "KITTY_DISABLE_WAYLAND=1 kitty --class bg-widget --override background_opacity=0.0 cava"
fi
