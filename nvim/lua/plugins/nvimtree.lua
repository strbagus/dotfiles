return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      filters = {
        dotfiles = true,
      }
    },
    config = function(_, opts)
      vim.g.loaded_netrw = 1;
      vim.g.loaded_netrwPlugin = 1;
      require('nvim-tree').setup(opts)
    end
  }
}
