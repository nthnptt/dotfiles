local map = vim.keymap.set

map("n", "x", '"_x', { desc = "Delete char without copying" })
map({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete without copying" })
map({ "n", "x" }, "<leader>c", '"_c', { desc = "Change without copying" })
map({ "n", "x" }, "<leader>p", '"0p', { desc = "Paste last yank" })
map("n", "dw", 'vb"_d', { desc = "Delete word backwards without copying" })

map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

map("n", "te", "<Cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<Tab>", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<S-Tab>", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })

map("n", "ss", "<Cmd>split<CR>", { desc = "Split below" })
map("n", "sv", "<Cmd>vsplit<CR>", { desc = "Split right" })
map("n", "sh", "<C-w>h", { desc = "Go to left window" })
map("n", "sj", "<C-w>j", { desc = "Go to lower window" })
map("n", "sk", "<C-w>k", { desc = "Go to upper window" })
map("n", "sl", "<C-w>l", { desc = "Go to right window" })

map("n", "<C-m>", "<C-i>", { desc = "Jump forward" })

map("n", "<leader>o", "o<Esc>^Da", { desc = "Open line below without comment" })
map("n", "<leader>O", "O<Esc>^Da", { desc = "Open line above without comment" })

map("n", "<leader>bd", function()
	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if #buf.windows == 0 and buf.changed == 0 then
			pcall(vim.api.nvim_buf_delete, buf.bufnr, {})
		end
	end
end, { desc = "Close hidden buffers" })

-- Copy `<path>#L<line>` to the system clipboard, ready to paste to an agent.
local function copy_path(modifier)
	local path = vim.fn.expand("%" .. modifier)
	if path == "" then
		return
	end
	vim.fn.setreg("+", path .. "#L" .. vim.fn.line("."))
end

map("n", "<leader>yf", function()
	copy_path(":.")
end, { desc = "Copy relative path with line" })
map("n", "<leader>yp", function()
	copy_path(":p")
end, { desc = "Copy absolute path with line" })

local short_langs = {
	typescriptreact = "tsx",
	javascriptreact = "jsx",
	typescript = "ts",
	javascript = "js",
}

-- Copy the selection as a fenced block with Obsidian-style attributes.
map("x", "<leader>cc", function()
	local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
	local first_line = math.min(vim.fn.line("v"), vim.fn.line("."))
	local lang = short_langs[vim.bo.filetype] or vim.bo.filetype
	local header = string.format('```%s filename="%s" line=%d', lang, vim.fn.expand("%:."), first_line)
	vim.fn.setreg("+", table.concat({ header, table.concat(lines, "\n"), "```" }, "\n") .. "\n")
	vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
end, { desc = "Copy selection as Markdown code block" })
