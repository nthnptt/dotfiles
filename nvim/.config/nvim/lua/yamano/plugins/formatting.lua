-- oxfmt only runs in projects that configure it, so prettier projects keep prettier.
local function has_oxfmt_config(dirname)
	local opts = { path = dirname, upward = true, limit = 1 }
	if vim.fs.find({ ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" }, opts)[1] then
		return true
	end
	local vite_config = vim.fs.find({ "vite.config.ts", "vite.config.js" }, opts)[1]
	if not vite_config then
		return false
	end
	local content = table.concat(vim.fn.readfile(vite_config), "\n")
	return content:find("vite%-plus") ~= nil and content:find("fmt%s*:") ~= nil
end

local php_cs_fixer_configs = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }

local web = { "oxfmt", "prettierd", "prettier", stop_after_first = true }

require("conform").setup({
	formatters_by_ft = {
		javascript = web,
		typescript = web,
		typescriptreact = web,
		json = web,
		css = web,
		scss = web,
		less = web,
		html = web,
		markdown = web,
		mdx = web,
		yaml = web,
		lua = { "stylua" },
		sh = { "shfmt" },
		fish = { "fish_indent" },
		php = { "php_cs_fixer" },
	},
	formatters = {
		oxfmt = {
			condition = function(_, ctx)
				return has_oxfmt_config(ctx.dirname)
			end,
		},
		-- Only in projects with a PHP-CS-Fixer config, run from the config's folder.
		php_cs_fixer = {
			condition = function(_, ctx)
				return vim.fs.find(php_cs_fixer_configs, { path = ctx.dirname, upward = true, limit = 1 })[1] ~= nil
			end,
			cwd = require("conform.util").root_file(php_cs_fixer_configs),
		},
	},
	format_on_save = function(bufnr)
		if vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 1000, lsp_format = "fallback" }
	end,
})
