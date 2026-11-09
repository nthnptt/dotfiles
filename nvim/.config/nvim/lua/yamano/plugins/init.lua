vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("yamano.pack", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	"https://github.com/craftzdog/solarized-osaka.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/b0o/incline.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("yamano.plugins.ui")
require("yamano.plugins.snacks")
require("yamano.plugins.navigation")
require("yamano.plugins.syntax")
require("yamano.plugins.keymaps")
