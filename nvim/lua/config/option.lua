vim.g.mapleader         = ' '
vim.g.maplocalleader    = ' '
vim.g.autopairs_enabled = true

vim.opt.number          = true
vim.opt.wrap            = true

vim.opt.tabstop         = 2
vim.opt.shiftwidth      = 2
vim.opt.shiftround      = true
vim.opt.scrolloff       = 10

vim.o.encoding          = "UTF-8"
vim.opt.backspace       = '2'
vim.opt.showcmd         = true
vim.opt.expandtab       = true
vim.opt.swapfile        = false
vim.opt.backup          = false

vim.cmd "set clipboard=unnamedplus"
vim.cmd "set relativenumber"

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.timeoutlen = 500

vim.api.nvim_exec([[
  augroup VisualEvent
    autocmd!
    autocmd InsertEnter * set timeoutlen=150
    autocmd InsertLeave * set timeoutlen=500
    autocmd ModeChanged *:[vV\x16]* set timeoutlen=150
    autocmd Modechanged [vV\x16]*:* set timeoutlen=500
  augroup END
]], false)
