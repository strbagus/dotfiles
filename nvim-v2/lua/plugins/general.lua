return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1,
		opts = {
			-- flavour = "mocha",
			transparent_background = false
		},
		config = function(_, opts)
			require('catppuccin').setup(opts)
			vim.cmd.colorscheme "catppuccin"
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
}
