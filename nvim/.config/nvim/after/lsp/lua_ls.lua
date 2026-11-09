return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			hint = {
				enable = true,
				paramType = true,
				setType = false,
				paramName = "Disable",
				semicolon = "Disable",
				arrayIndex = "Disable",
			},
			diagnostics = {
				globals = { "Snacks", "Yamano" },
				disable = { "missing-fields" },
			},
		},
	},
}
