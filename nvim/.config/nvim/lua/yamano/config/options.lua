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

vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.path:append("**")
vim.o.wildmode = "longest:full,full"
vim.opt.wildignore:append({
	"*/node_modules/*",
	"*.o",
	"*.obj",
	"*.pyc",
	"*.class",
	"*.jar",
	"*/vendor/*",
	"*/target/*",
})

vim.o.swapfile = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("cache") .. "/undodir"

vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
