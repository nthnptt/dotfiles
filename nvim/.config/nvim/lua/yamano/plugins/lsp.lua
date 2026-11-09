require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"vtsls",
		"eslint-lsp",
		"oxlint",
		"tailwindcss-language-server",
		"css-lsp",
		"rust-analyzer",
		"phpactor",
		"phpstan",
		"php-cs-fixer",
		"prettier",
		"prettierd",
		"oxfmt",
		"stylua",
		"shfmt",
	},
	auto_update = false,
	run_on_start = true,
})

vim.lsp.config("*", {
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
})

local function has_file(root, names)
	for _, name in ipairs(names) do
		if vim.uv.fs_stat(vim.fs.joinpath(root, name)) then
			return true
		end
	end
	return false
end

-- Prefer the project's own binary, fall back to Mason's.
local function php_tool(root, name)
	local vendor_bin = vim.fs.joinpath(root, "vendor", "bin", name)
	return vim.fn.executable(vendor_bin) == 1 and vendor_bin or vim.fn.exepath(name)
end

-- PHPStan and PHP-CS-Fixer run through phpactor, only in projects that configure them.
vim.lsp.config("phpactor", {
	before_init = function(params, config)
		local root = config.root_dir
		if not root then
			return
		end
		local opts = params.initializationOptions or {}
		if has_file(root, { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon" }) then
			opts["language_server_phpstan.enabled"] = true
			opts["language_server_phpstan.bin"] = php_tool(root, "phpstan")
		end
		if has_file(root, { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }) then
			opts["language_server_php_cs_fixer.enabled"] = true
			opts["language_server_php_cs_fixer.bin"] = php_tool(root, "php-cs-fixer")
		end
		params.initializationOptions = opts
	end,
})

vim.lsp.config("tailwindcss", {
	filetypes = vim.tbl_filter(function(ft)
		return ft ~= "php"
	end, vim.lsp.config.tailwindcss.filetypes),
})

vim.lsp.enable({
	"eslint",
	"oxlint",
	"lua_ls",
	"cssls",
	"vtsls",
	"tailwindcss",
	"rust_analyzer",
	"phpactor",
})
