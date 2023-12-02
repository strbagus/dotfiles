vim.keymap.set("x", "p", "\"_dP")
vim.keymap.set("n", "<C-d>", "mzJ`z")
vim.keymap.set("n", ">", ":bnext <cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<", ":bprevious <cr>", { noremap = true, silent = true })
vim.keymap.set({ 'i', 'v'}, "jk", "<ESC>", { silent = true })
vim.keymap.set("n", "<C-w>", ":bdelete <cr>", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<S-w>', 'viw', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'D', '"_D', { noremap = true })

-- File Explorer
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { silent = true })

-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>', '<cmd>resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>', '<cmd>resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +3<CR>', { noremap = true, silent = true })

-- Comment line toggle
vim.keymap.set('n', '<leader>/',
  function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end)
vim.keymap.set('v', '<leader>/', "<esc><cmd>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<cr>")

-- Fuzy finding Telescope
vim.keymap.set('n', '<leader>ff', function() require('telescope.builtin').find_files() end)
vim.keymap.set('n', '<leader>fo', function() require('telescope.builtin').oldfiles() end)
vim.keymap.set('n', '<leader>fg', function() require('telescope.builtin').live_grep() end)
vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').help_tags() end)

-- Git
vim.keymap.set('n', '<leader>gd', "<cmd>Gitsigns diffthis<cr>")
vim.keymap.set('n', '<leader>gl', "<cmd>Gitsigns toggle_linehl<cr>")
vim.keymap.set('n', '<leader>gb', "<cmd>GitBlameToggle<cr>")

-- Terminal
vim.keymap.set('n', '<leader>th', "<cmd>ToggleTerm size=15 direction=horizontal<cr>")
vim.keymap.set('n', '<leader>tv', "<cmd>ToggleTerm size=50 direction=vertical<cr>")
vim.keymap.set('n', '<leader>tf', "<cmd>ToggleTerm direction=float<cr>")

-- Tab Function
vim.keymap.set('n', '<C-m>', "<cmd>SymbolsOutline<cr>")

-- Search text
vim.keymap.set('n', '/', '/\\c', { noremap = true })
vim.keymap.set('n', '?', '?\\C', { noremap = true })
