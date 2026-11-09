local map = vim.keymap.set

map("n", "]]", function()
	Snacks.words.jump(vim.v.count1)
end, { desc = "Next reference" })
map("n", "[[", function()
	Snacks.words.jump(-vim.v.count1)
end, { desc = "Previous reference" })

map("n", ";f", function()
	Snacks.picker.files()
end, { desc = "Find files" })
map("n", ";r", function()
	Snacks.picker.grep()
end, { desc = "Live grep" })
map("n", ";;", function()
	Snacks.picker.resume()
end, { desc = "Resume last picker" })
map("n", "\\\\", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", ";e", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
map("n", ";n", function()
	Snacks.picker.notifications()
end, { desc = "Notification history" })
map("n", ";h", function()
	Snacks.picker.git_diff()
end, { desc = "Git hunks" })

map("n", "sf", function()
	require("oil").open_float(nil, { preview = {} })
end, { desc = "File explorer" })
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("yamano.oil", { clear = true }),
	pattern = "oil",
	callback = function(args)
		local actions = require("oil.actions")
		map("n", "h", actions.parent.callback, { buffer = args.buf, desc = "Parent directory" })
		map("n", "q", actions.close.callback, { buffer = args.buf, desc = "Close oil" })
	end,
})

-- TypeScript: skip the .d.ts and land on the real code. Elsewhere: implementations.
local function goto_source_definition()
	local client = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })[1]
	if not client then
		Snacks.picker.lsp_implementations()
		return
	end
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
	client:exec_cmd({
		title = "Go to source definition",
		command = "typescript.goToSourceDefinition",
		arguments = { params.textDocument.uri, params.position },
	}, { bufnr = 0 }, function(err, result)
		if err or not result or vim.tbl_isempty(result) then
			vim.notify("No source definition found", vim.log.levels.WARN)
			return
		end
		if #result == 1 then
			vim.lsp.util.show_document(result[1], client.offset_encoding, { focus = true })
			return
		end
		vim.fn.setqflist({}, " ", {
			title = "Source definitions",
			items = vim.lsp.util.locations_to_items(result, client.offset_encoding),
		})
		Snacks.picker.qflist()
	end)
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("yamano.lsp_keymaps", { clear = true }),
	callback = function(args)
		local function lsp_map(mode, lhs, rhs, desc, opts)
			map(mode, lhs, rhs, vim.tbl_extend("force", { buffer = args.buf, desc = desc }, opts or {}))
		end

		lsp_map("n", "gd", function()
			Snacks.picker.lsp_definitions()
		end, "Go to definition")
		lsp_map("n", "gD", function()
			Snacks.picker.lsp_declarations()
		end, "Go to declaration")
		lsp_map("n", "gy", function()
			Snacks.picker.lsp_type_definitions()
		end, "Go to type definition")
		lsp_map("n", "gr", function()
			Snacks.picker.lsp_references()
		end, "References", { nowait = true })
		lsp_map("n", "gI", goto_source_definition, "Go to source definition / implementation")
		lsp_map("n", ";c", function()
			Snacks.picker.lsp_incoming_calls()
		end, "Incoming calls")

		lsp_map("n", "K", vim.lsp.buf.hover, "Hover")
		lsp_map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
		lsp_map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

		lsp_map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
		lsp_map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
		lsp_map("n", "<leader>cR", function()
			Snacks.rename.rename_file()
		end, "Rename file")
		lsp_map("n", "<leader>cl", "<Cmd>checkhealth vim.lsp<CR>", "LSP info")
	end,
})

map("n", "<C-j>", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map({ "n", "x" }, "<leader>f", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format" })
