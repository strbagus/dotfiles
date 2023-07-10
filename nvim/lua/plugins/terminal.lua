return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    shade_terminals = false,
  },
  config = function (_, opts)
    require('toggleterm').setup(opts)
    -- local Terminal  = require('toggleterm.terminal').Terminal
    -- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
    -- function _lazygit_toggle()
    --   lazygit:toggle()
    -- end
    -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
function _G.set_terminal_keymaps()
  local buf = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], buf)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], buf)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], buf)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], buf)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], buf)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], buf)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], buf)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
