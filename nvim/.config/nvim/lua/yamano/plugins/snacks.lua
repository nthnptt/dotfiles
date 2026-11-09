require("snacks").setup({
	notifier = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	scroll = { enabled = false },
	lazygit = {
		theme = {
			activeBorderColor = { fg = "WarningMsg", bold = true },
		},
	},
	picker = {
		enabled = true,
		sources = {
			files = { hidden = true },
			grep = { hidden = true },
			buffers = { jump = { reuse_win = true } },
		},
	},
})
