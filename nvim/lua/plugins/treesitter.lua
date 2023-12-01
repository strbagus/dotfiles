return {
  "nvim-treesitter/nvim-treesitter",
  --[[ init = function()
    require("core.utils").lazy_load "nvim-treesitter"
  end, ]]
  dependencies = { 
    "windwp/nvim-ts-autotag", 
    -- "JoosepAlviste/nvim-ts-context-commentstring" 
  },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "lua", "vim"
    },
    highlight = {
      enable = true,
      disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    -- context_commentstring = { enable = true, enable_autocmd = false },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)

    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade"
    }

    vim.filetype.add({
      pattern = {
        ['.*%.blade%.php'] = 'blade',
      },
    })
  end
}
