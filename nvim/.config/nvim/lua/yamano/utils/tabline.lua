local M = {}

local left_edge = "\u{E0BA}"
local right_edge = "\u{E0B8}"

local function set_highlights()
	local c = require("solarized-osaka.colors").setup()
	vim.api.nvim_set_hl(0, "YamanoTabActive", { fg = c.base04, bg = c.yellow, bold = true })
	vim.api.nvim_set_hl(0, "YamanoTabActiveSep", { fg = c.yellow })
	vim.api.nvim_set_hl(0, "YamanoTabInactive", { fg = c.base0, bg = c.base02 })
	vim.api.nvim_set_hl(0, "YamanoTabInactiveSep", { fg = c.base02 })
	vim.api.nvim_set_hl(0, "YamanoTabFill", {})
end

local function label(tab)
	local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
	if vim.bo[buf].buftype == "terminal" then
		return "[Terminal]"
	end

	local modified = vim.bo[buf].modified and "[+] " or ""
	local path = vim.api.nvim_buf_get_name(buf)
	if path == "" then
		return modified .. "[No Name]"
	end

	local name = vim.fn.fnamemodify(path, ":t")
	local icon = require("mini.icons").get("file", name)
	if vim.fn.strchars(name) > 20 then
		name = vim.fn.strcharpart(name, 0, 17) .. "..."
	end
	name = name:gsub("%%", "%%%%")
	return modified .. icon .. " " .. name
end

function M.render()
	local current = vim.api.nvim_get_current_tabpage()
	local parts = {}
	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local group = tab == current and "YamanoTabActive" or "YamanoTabInactive"
		local sep = "%#" .. group .. "Sep#"
		table.insert(
			parts,
			sep .. left_edge .. "%#" .. group .. "#   " .. label(tab) .. "   " .. sep .. right_edge
		)
	end
	return table.concat(parts) .. "%#YamanoTabFill#"
end

function M.setup()
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = vim.api.nvim_create_augroup("yamano.tabline", { clear = true }),
		callback = set_highlights,
	})
	vim.o.showtabline = 1
	vim.o.tabline = "%!v:lua.Yamano.tabline.render()"
end

return M
