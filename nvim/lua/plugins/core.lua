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
    priority = 1,
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
      { "gcc", mode = { "n" }, desc = "Comment toggle linewise" },
      { "gbc", mode = { "v" }, desc = "Comment toggle blockwise" },
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
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end
  }
}
