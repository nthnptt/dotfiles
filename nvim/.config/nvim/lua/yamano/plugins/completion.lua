require("blink.cmp").setup({
	keymap = { preset = "enter" },
	appearance = {
		kind_icons = Yamano.icons.kinds,
	},
	completion = {
		accept = {
			auto_brackets = { enabled = true },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				treesitter = { "lsp" },
			},
		},
		ghost_text = { enabled = false },
	},
	cmdline = {
		completion = {
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			list = {
				selection = { preselect = false },
			},
			ghost_text = { enabled = false },
		},
	},
})
