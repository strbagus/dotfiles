return {
	{
		"epwalsh/obsidian.nvim",
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/*.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Notes/**/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Notes/**/*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			dir = "~/Documents/Notes/",
		},
		config = function(_, opts)
			require("obsidian").setup(opts)
			vim.opt.conceallevel = 2
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		ft = { "markdown", "obsidian" },
		opts = {
			conceal = {
				enabled = true,
			},
			render_modes = true,
		},
	},
}
