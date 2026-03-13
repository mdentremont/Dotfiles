local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",

	default_prog = {
		-- Launch tmux when WezTerm starts
		"bash",
		"-c",
		"/opt/homebrew/bin/tmux new -A -s quake fish && exit",
	},

	enable_tab_bar = false,

	font = wezterm.font("FiraCode Nerd Font Mono"),

	initial_cols = 600,
	initial_rows = 200,

	window_background_opacity = 0.97,
}
