return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/OneD/NotesObs/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/OneD/NotesObs/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "~/Documents/OneD/NotesObs/",
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
  end,
}
