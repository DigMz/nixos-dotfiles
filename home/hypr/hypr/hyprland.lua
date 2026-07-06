local modules = {
	"monitors",
	"autostart",
	"env_vars",
	"permissions",
	"theme",
	"misc",
	"input",
	"keybinds",
	"rules",
}

for _, name in ipairs(modules) do
	require("conf." .. name)
end
