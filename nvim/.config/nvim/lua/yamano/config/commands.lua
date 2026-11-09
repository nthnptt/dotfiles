vim.api.nvim_create_user_command("ToggleFormatter", function()
	vim.b.disable_autoformat = not vim.b.disable_autoformat
	vim.notify(vim.b.disable_autoformat and "Format on save disabled" or "Format on save enabled")
end, { desc = "Toggle format on save for the current buffer" })
