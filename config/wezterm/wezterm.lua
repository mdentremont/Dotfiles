return {
	default_prog = {
		-- Launch tmux when WezTerm starts
		"bash",
		"-c",
		"/opt/homebrew/bin/tmux new -A -s quake zsh && exit",
	},
	-- Hide the tab bar
	enable_tab_bar = false,
	initial_cols = 600,
	initial_rows = 200,
}
