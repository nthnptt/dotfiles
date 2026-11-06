vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mouse = ""
vim.o.clipboard = "unnamedplus"

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.opt.iskeyword:append("-")

vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.cmdheight = 0
vim.o.laststatus = 3
vim.o.winborder = "rounded"
vim.o.pumheight = 10
vim.o.pumblend = 10
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.title = true
vim.opt.fillchars:append({ diff = "╱" })
