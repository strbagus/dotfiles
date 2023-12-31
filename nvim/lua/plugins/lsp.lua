return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    {
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd['MasonUpdate'])
      end,
    },
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    local lsp = require('lsp-zero').preset({})

    require('mason').setup({})
    require('mason-lspconfig').setup({
      ensure_installed = { 'tsserver' },
      handlers = {
        lsp.default_setup
      }
    })
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
  end
}
