return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/Notes/**/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/Notes/**/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/Documents/Notes/",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    vim.opt.conceallevel = 1;
  end,
}
