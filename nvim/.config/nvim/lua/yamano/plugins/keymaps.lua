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
