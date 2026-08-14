wal -i "$1" -nst
${HOME}/.config/quickshell/wallpaper_select/get_wal_colors_in_lua.sh >${HOME}/.config/hypr/conf/colors.lua
awww img "$1" -t center --transition-fps 144
wayle panel restart
