require("solarized-osaka").setup({
	style = "vivid",
	transparent = true,
})
vim.cmd.colorscheme("solarized-osaka")

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("tiny-cmdline").setup({
	position = {
		x = "50%",
		y = "20%",
	},
})
