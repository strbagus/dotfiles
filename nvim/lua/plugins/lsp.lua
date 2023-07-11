return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lsp = require('lsp-zero').preset({})
    lsp.ensure_installed({
      'tsserver'
    })
    lsp.on_attach(function(_, bufnr)
      lsp.default_keymaps({buffer = bufnr})
      local opts = { buffer = bufnr, remap = false }
      vim.keymap.set('n', 'mk', function() vim.lsp.buf.definition() end, opts)
      vim.keymap.set('n', 'mj', function() vim.lsp.buf.hover() end, opts)
      vim.keymap.set('n', 'ml', function() vim.lsp.buf.references() end, opts)
    end)
    lsp.setup()
  end
}
