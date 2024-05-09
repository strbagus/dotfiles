return {
	"nvimtools/none-ls.nvim",
  dependecies = {
    "nvimtools/none-ls-extras.nvim"
  },
	config = function()
		local null_ls = require("null-ls")
    local null_lsd = require("null-ls.diagnostics")

		null_ls.setup({
      debug = true,
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettierd,
				null_lsd.eslint_d,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
