local neovim = "kitty nvim"
local browser = "zen-browser"
local scripts_dir = "~/.config/hypr/scripts/"
local wallpaper_change_sh = scripts_dir .. "change_wallpaper.sh "
local wallpaper_dir = "~/Pictures/Wallpapers/"
local wallpaper = wallpaper_dir .. "digital-render.jpg"

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user restart hypridle")
  --
	hl.exec_cmd("wayle shell")
	hl.exec_cmd("wayle panel start")
	hl.exec_cmd("awww-daemon")

	-- hl.exec_cmd(wallpaper_change_sh .. wallpaper)

	-- hl.exec_cmd("nm-applet")
	-- hl.exec_cmd("blueman-applet")
end)
