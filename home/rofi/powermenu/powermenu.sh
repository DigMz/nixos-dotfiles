#!/usr/bin/env bash

# option_lock=" Lock"
# option_logout="󰍃 Logout"
# option_sleep="󰤄 Suspend"
# option_hibernate=" Hibernate"
# option_reboot=" Reboot"
# option_shutdown="󰤂 Shutdown"

option_lock=""
option_logout="󰍃"
option_sleep="󰤄"
option_hibernate=""
option_reboot=""
option_shutdown=""
yes='󰄴  Yes'
no='  No'

username=$(whoami)
prompt="${username^^}"
mesg="input"

export WALLPAPER_PATH=$(awww query -j | jq '.[] | .[] | .displaying.image')

theme="${HOME}/dotfiles/nixos/home/rofi/powermenu/style.rasi"
# theme="~/.cache/wal/colors-rofi-dark.rasi"

list_col=2
list_row=3

# Rofi CMD
rofi_cmd() {
  rofi \
    -theme-str "listview {columns: $list_col; lines: $list_row;}" \
    -theme-str 'textbox-prompt-colon {str: " ";}' \
    -dmenu \
    -p "$prompt" \
    -mesg "$mesg" \
    -markup-rows \
    -theme ${theme}
  # rofi -dmenu -p "$prompt" -mesg "$mesg" -markup-rows
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$option_lock\n$option_logout\n$option_sleep\n$option_hibernate\n$option_reboot\n$option_shutdown" | rofi_cmd
}

# Confirmation CMD
confirm_cmd() {
  # rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
  #   -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
  #   -theme-str 'listview {columns: 2; lines: 1;}' \
  #   -theme-str 'element-text {horizontal-align: 0.5;}' \
  #   -theme-str 'textbox {horizontal-align: 0.5;}' \
  rofi \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you Sure?' \
    -theme powermenu/confirm_style.rasi
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Confirm and execute
confirm_run() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    ${1} && ${2} && ${3} -dmenu
  else
    exit
  fi
}

# Execute Command
run_cmd() {
  if [[ "$1" == '--opt1' ]]; then
    # betterlockscreen -l
    echo '--opt1'
    hyprlock
  elif [[ "$1" == '--opt2' ]]; then
    echo '--opt2'
    confirm_run 'hyprshutdown'
  elif [[ "$1" == '--opt3' ]]; then
    echo '--opt3'
    confirm_run 'systemctl suspend'
  elif [[ "$1" == '--opt4' ]]; then
    echo '--opt4'
    confirm_run 'systemctl hibernate'
  elif [[ "$1" == '--opt5' ]]; then
    echo '--opt5'
    confirm_run 'systemctl reboot'
  elif [[ "$1" == '--opt6' ]]; then
    echo '--opt6'
    confirm_run 'systemctl poweroff'
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$option_lock)
  run_cmd --opt1
  ;;
$option_logout)
  run_cmd --opt2
  ;;
$option_sleep)
  run_cmd --opt3
  ;;
$option_hibernate)
  run_cmd --opt4
  ;;
$option_reboot)
  run_cmd --opt5
  ;;
$option_shutdown)
  run_cmd --opt6
  ;;
esac
