return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    cmd = "Alpha",
    config = function()
      local alpha = require("alpha")
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        "       ██╗    ██╗ █████╗ ██╗  ██╗████████╗██╗   ██╗███╗   ██╗██╗   ██╗ █████╗          ",
        "       ██║    ██║██╔══██╗██║ ██╔╝╚══██╔══╝██║   ██║████╗  ██║╚██╗ ██╔╝██╔══██╗         ",
        "       ██║ █╗ ██║███████║█████╔╝    ██║   ██║   ██║██╔██╗ ██║ ╚████╔╝ ███████║         ",
        "       ██║███╗██║██╔══██║██╔═██╗    ██║   ██║   ██║██║╚██╗██║  ╚██╔╝  ██╔══██║         ",
        "       ╚███╔███╔╝██║  ██║██║  ██╗   ██║   ╚██████╔╝██║ ╚████║   ██║   ██║  ██║         ",
        "        ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝         ",
        "                                                                                       ",
        " ███╗   ███╗███████╗███╗   ██╗ ██████╗ ██╗  ██╗ ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗  ",
        " ████╗ ████║██╔════╝████╗  ██║██╔════╝ ██║ ██╔╝██╔═══██╗██╔══██╗██║████╗  ██║██╔════╝  ",
        " ██╔████╔██║█████╗  ██╔██╗ ██║██║  ███╗█████╔╝ ██║   ██║██║  ██║██║██╔██╗ ██║██║  ███╗ ",
        " ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║   ██║██╔═██╗ ██║   ██║██║  ██║██║██║╚██╗██║██║   ██║ ",
        " ██║ ╚═╝ ██║███████╗██║ ╚████║╚██████╔╝██║  ██╗╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝ ",
        " ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝  ",
      }
      alpha.setup(dashboard.config)
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
    config = function(_, opts)
      vim.cmd.colorscheme "catppuccin";
      require('catppuccin').setup(opts)
    end
  },
	'wakatime/vim-wakatime',
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    opts = function()
      local commentstring_avail, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require('bufferline').setup{}
    end
  }
}
