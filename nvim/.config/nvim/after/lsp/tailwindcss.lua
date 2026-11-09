-- nvim-lspconfig's defaults, without PHP.
local defaults = dofile(vim.api.nvim_get_runtime_file("lsp/tailwindcss.lua", false)[1])

return {
	filetypes = vim.tbl_filter(function(ft)
		return ft ~= "php"
	end, defaults.filetypes),
}
