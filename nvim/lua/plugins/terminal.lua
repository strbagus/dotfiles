return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    shade_terminals = false,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    function Lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
    function Set_terminal_keymaps()
      local buf = { buffer = 0 }
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], buf)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], buf)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], buf)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], buf)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], buf)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua Set_terminal_keymaps()")
  end,
}
