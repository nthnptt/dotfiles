local M = {}

local theme_path = vim.fn.stdpath("cache") .. "/leaf-theme.toml"

-- Each leaf color comes from a Neovim highlight group, like Snacks does for lazygit.
-- stylua: ignore
local theme = {
	ui = {
		toc_bg                      = { bg = "NormalFloat" },
		toc_border                  = { fg = "WarningMsg" },
		content_bg                  = { bg = "NormalFloat" },
		scrollbar_hover             = { fg = "Special" },
		status_bg                   = { bg = "StatusLine" },
		status_separator            = { fg = "Comment" },
		status_brand_fg             = { bg = "NormalFloat" },
		status_brand_bg             = { fg = "Special" },
		status_filename_fg          = { fg = "StatusLine" },
		status_filename_bg          = { bg = "Visual" },
		status_watch_fg             = { fg = "DiagnosticOk" },
		status_watch_bg             = { bg = "DiffAdd" },
		status_reloaded_fg          = { bg = "NormalFloat" },
		status_reloaded_bg          = { fg = "DiagnosticOk" },
		status_search_fg            = { fg = "Search" },
		status_search_bg            = { bg = "Visual" },
		status_success_fg           = { fg = "DiagnosticOk" },
		status_success_bg           = { bg = "DiffAdd" },
		status_warning_fg           = { fg = "DiagnosticWarn" },
		status_error_fg             = { fg = "DiagnosticError" },
		status_error_bg             = { bg = "DiffDelete" },
		status_shortcut_fg          = { fg = "Comment" },
		status_percent_fg           = { fg = "Special" },
		toc_header_fg               = { fg = "Comment" },
		toc_active_bg               = { bg = "CursorLine" },
		toc_inactive_bg             = { bg = "NormalFloat" },
		toc_accent                  = { fg = "Special" },
		toc_index_inactive          = { fg = "LineNr" },
		toc_primary_active          = { fg = "Normal" },
		toc_primary_inactive        = { fg = "Comment" },
		toc_secondary_inactive      = { fg = "LineNr" },
		toc_secondary_text_active   = { fg = "Normal" },
		toc_secondary_text_inactive = { fg = "Comment" },
	},
	markdown = {
		search_highlight_bg = { bg = "Visual" },
		search_match_bg     = { bg = "CurSearch" },
		code_gutter         = { fg = "LineNr" },
		blockquote_marker   = { fg = "Comment" },
		list_level_1        = { fg = "@markup.list" },
		list_level_2        = { fg = "String" },
		list_level_3        = { fg = "Keyword" },
		ordered_list        = { fg = "@markup.list" },
		table_border        = { fg = "FloatBorder" },
		table_separator     = { fg = "WinSeparator" },
		table_header        = { fg = "Title" },
		table_cell          = { fg = "Normal" },
		heading_1           = { fg = "@markup.heading.1.markdown" },
		heading_2           = { fg = "@markup.heading.2.markdown" },
		heading_3           = { fg = "@markup.heading.3.markdown" },
		heading_4           = { fg = "@markup.heading.4.markdown" },
		heading_other       = { fg = "@markup.heading.5.markdown" },
		heading_underline   = { fg = "WinSeparator" },
		code_frame          = { fg = "FloatBorder" },
		code_label          = { fg = "Comment" },
		inline_code_fg      = { fg = "@markup.raw" },
		inline_code_bg      = { bg = "CursorLine" },
		rule                = { fg = "WinSeparator" },
		link_icon           = { fg = "@markup.link" },
		link_text           = { fg = "@markup.link" },
		link_hover          = { fg = "@markup.link.label" },
		blockquote_text     = { fg = "@markup.quote" },
		text                = { fg = "Normal" },
		strong_text         = { fg = "@markup.strong" },
		latex_inline_fg     = { fg = "@markup.math" },
		latex_inline_bg     = { bg = "CursorLine" },
		latex_block_fg      = { fg = "@markup.math" },
		mermaid_keyword     = { fg = "Keyword" },
		mermaid_arrow       = { fg = "Operator" },
		mermaid_label       = { fg = "String" },
		mermaid_block_fg    = { fg = "Normal" },
		mark_fg             = { fg = "Normal" },
		mark_bg             = { bg = "Visual" },
		task_checked        = { fg = "@markup.list.checked" },
		task_unchecked      = { fg = "@markup.list.unchecked" },
		alert_note          = { fg = "DiagnosticInfo" },
		alert_tip           = { fg = "DiagnosticOk" },
		alert_important     = { fg = "DiagnosticHint" },
		alert_warning       = { fg = "DiagnosticWarn" },
		alert_caution       = { fg = "DiagnosticError" },
	},
}

-- A group without that color (e.g. a transparent background) falls back to the terminal default.
local function color(spec)
	local attr, group = next(spec)
	local value = vim.api.nvim_get_hl(0, { name = group, link = false })[attr]
	return value and ('"#%06x"'):format(value) or '"reset"'
end

--- Writes the leaf theme for the current colorscheme and returns its path.
function M.write_theme()
	local syntax = vim.o.background == "light" and "base16-ocean.light" or "base16-ocean.dark"
	local lines = { 'base = "ocean"', ("syntax = %q"):format(syntax) }
	for _, section in ipairs({ "ui", "markdown" }) do
		vim.list_extend(lines, { "", "[" .. section .. "]" })
		for key, spec in vim.spairs(theme[section]) do
			table.insert(lines, key .. " = " .. color(spec))
		end
	end
	vim.fn.writefile(lines, theme_path)
	return theme_path
end

return M
