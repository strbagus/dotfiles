return {
	"nvimtools/none-ls.nvim",
	dependecies = {
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			autorstart = true,
			debug = true,
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.formatting.pint,
				null_ls.builtins.formatting.clang_format,
				-- null_ls.diagnostics.eslint,
				-- require("none-ls.diagnostics.eslint")
				-- null_ls.builtins.formatting.eslint,
				-- require("null-ls.diagnostics.eslint"),
				-- require("none-ls.diagnostics.eslint_d"),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
