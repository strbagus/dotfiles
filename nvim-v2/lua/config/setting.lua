vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.autopairs_enabled = true
vim.g.have_nerd_font = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.showmode = false
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = false
vim.o.wrap = true
vim.o.encoding = "UTF-8"

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)
