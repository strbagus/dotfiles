return {
  "max397574/better-escape.nvim",
  config = function()
    require("better_escape").setup {
      mapping = { "jk" },
      timeout = 150,
      clear_empty_lines = false,
      keys = "<Esc>"
    }
  end,
}
