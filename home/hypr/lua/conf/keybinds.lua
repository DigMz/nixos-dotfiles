local terminal = "kitty"
local fileManager = "dolphin"
local menu = "$HOME/dotfiles/nixos/home/rofi/launcher/launcher.sh"
local neovim = "kitty nvim"
local browser = "zen"
local powermenu = "${HOME}/dotfiles/nixos/home/rofi/powermenu/powermenu.sh"

local super = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(super .. " + TAB", hl.dsp.exec_cmd("wayle panel toggle"))

hl.bind(super .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(super .. " + C", hl.dsp.window.close())
-- local shutdown_cmd = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()"
hl.bind(super .. " + SHIFT + M", hl.dsp.exec_cmd(powermenu))
hl.bind(super .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(super .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(super .. " + F", hl.dsp.window.fullscreen())
hl.bind(super .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(super .. " + P", hl.dsp.window.pin())
hl.bind(super .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(super .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(super .. " + N", hl.dsp.exec_cmd(neovim))
hl.bind(super .. " + B", hl.dsp.exec_cmd(browser))

-- Move focus with mainMod + arrow keys
hl.bind(super .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(super .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(super .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(super .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch to a submap called `resize`.
hl.bind("ALT + R", function()
	hl.dispatch(hl.dsp.exec_cmd("hyprctl notify 1 2000 0 'Using Resize Keymap'"))
	hl.dispatch(hl.dsp.submap("resize"))
end)

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("H", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	-- hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("catchall", hl.dsp.submap("reset"))
end)
-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(super .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(super .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(super .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(super .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(super .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(super .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(super .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(super .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	super .. " + SHIFT + PERIOD",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	super .. " + SHIFT + COMMA",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	super .. " + CTRL + PERIOD",
	hl.dsp.exec_cmd("brightnessctl -n1000 set 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	super .. " + CTRL + COMMA",
	hl.dsp.exec_cmd("brightnessctl -n1000 set 5%-"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
-- export HYPRSHOT_DIR = ~/Images/Screenshots/
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -z --clipboard-only"))
hl.bind(super .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m region -z -o ~/Pictures/Screenshots"))

hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprpicker -a"))

-- Notification Daemon swaync
-- Toggle control center
hl.bind(super .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Clipboard
-- exec-once = wl-paste --watch cliphist store
-- bind = CTRL $mainMod, c, exec, uwsm app -- rofi -modi clipboard:~/.config/rofi/launchers/cliphist-rofi-img -show clipboard -show-icons -theme ~/.config/rofi/rasis/cliphist_theme.rasi
