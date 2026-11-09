local function find_file(root, names)
	for _, name in ipairs(names) do
		local path = vim.fs.joinpath(root, name)
		if vim.uv.fs_stat(path) then
			return path
		end
	end
end

-- Prefer the project's own binary, fall back to Mason's.
local function php_tool(root, name)
	local vendor_bin = vim.fs.joinpath(root, "vendor", "bin", name)
	return vim.fn.executable(vendor_bin) == 1 and vendor_bin or vim.fn.exepath(name)
end

-- True when the project's own phpactor config already decides `key`.
local function project_sets(root, key)
	for _, name in ipairs({ ".phpactor.json", ".phpactor.yml" }) do
		local fd = io.open(vim.fs.joinpath(root, name), "r")
		if fd then
			local content = fd:read("*a")
			fd:close()
			if content:find(key, 1, true) then
				return true
			end
		end
	end
	return false
end

local tools = {
	{
		prefix = "language_server_phpstan",
		bin = "phpstan",
		configs = { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon" },
	},
	{
		prefix = "language_server_php_cs_fixer",
		bin = "php-cs-fixer",
		configs = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" },
	},
}

return {
	-- Run from the project root, so phpactor's tools never run in Neovim's cwd.
	cmd = function(dispatchers, config)
		return vim.lsp.rpc.start({ "phpactor", "language-server" }, dispatchers, { cwd = config.root_dir })
	end,
	-- PHPStan and PHP-CS-Fixer only run in projects that configure them,
	-- unless the project's .phpactor.json/.yml already decides.
	before_init = function(params, config)
		local root = config.root_dir
		if not root then
			return
		end
		local opts = params.initializationOptions or {}
		for _, tool in ipairs(tools) do
			local config_file = find_file(root, tool.configs)
			if config_file and not project_sets(root, tool.prefix .. ".enabled") then
				opts[tool.prefix .. ".enabled"] = true
				opts[tool.prefix .. ".bin"] = php_tool(root, tool.bin)
				opts[tool.prefix .. ".config"] = config_file
			end
		end
		params.initializationOptions = opts
	end,
}
