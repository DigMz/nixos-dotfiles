-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

-- Floating Zen Browser Picture in Picture Windows
hl.window_rule({
	name = "Zen Picture-in-Picture",
	match = { title = "^(Picture-in-Picture)$" },

	float = true,
	pin = true,
	opacity = 1,
})

-- Floating Discord Picture-in-Picture VC
hl.window_rule({
	name = "Discord Picture-in-Picture",
	match = { initial_title = "^(Discord Popout)$" },

	float = true,
	pin = true,
})

hl.window_rule({
	name = "Zen Browser to Workspace 1",
	match = { initial_title = "^(Zen Browser)$" },

	workspace = 1,
})

-- hl.window_rule({
-- 	name = "Neovim to Workspace 2",
-- 	match = { initial_title = "kitty" },
--
-- 	workspace = 2,
-- })

hl.window_rule({
	name = "Discord to Workspace 3",
	match = { initial_title = "^(Discord)$" },

	workspace = 3,
})

-- Take focus and pin with Rofi windows
hl.window_rule({
	name = "Rofi Focus/Pin",
	match = { title = "^(rofi - )$" },

	stay_focused = true,
	pin = true,
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
