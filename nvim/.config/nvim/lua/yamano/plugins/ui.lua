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

local root_markers = {
	{ ".git", "lua", "package.json", "Makefile", "Cargo.toml", "go.mod", "pyproject.toml" },
}

local function root_name()
	local root = vim.fs.root(0, root_markers)
	if not root or root == vim.fn.getcwd() then
		return ""
	end
	return vim.fs.basename(root)
end

local function pretty_path()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		return ""
	end
	local parts = vim.split(vim.fn.fnamemodify(path, ":.:~"), "/", { plain = true })
	if #parts > 3 then
		parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
	end
	return (table.concat(parts, "/"):gsub("%%", "%%%%"))
end

local function macro()
	local reg = vim.fn.reg_recording()
	return reg == "" and "" or "recording @" .. reg
end

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		refresh = {
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
				"RecordingEnter",
				"RecordingLeave",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			root_name,
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			pretty_path,
		},
		lualine_x = { macro, "diagnostics", "diff" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
