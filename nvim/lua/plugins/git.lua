return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = vim.fn.executable "git" == 1,
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "▎" },
        untracked = { text = "┆" },
      },
        signcolumn = true,
        numhl = true,
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_date_format = '%d %b %y, %I:%M%p';
    end
  },
}
