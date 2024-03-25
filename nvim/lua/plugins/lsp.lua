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
      ensure_installed = {},
      handlers = {
        lsp.default_setup
      }
    })
    lsp.on_attach(function(_, bufnr)
      lsp.default_keymaps({buffer = bufnr})
    end)
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
  end
}
