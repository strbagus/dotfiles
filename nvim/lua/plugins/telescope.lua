return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      file_ignore_pattern = { "node_modules", "vendor" }
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
  end
}
