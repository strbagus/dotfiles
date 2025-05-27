return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"volar",
					-- "tsserver",
          "ts_ls",
					"intelephense",
					"clangd",
					"gopls",
					"pylsp",
				},
				handlers = {
					function(server_name)
						local initConfig = {}
						if server_name == "volar" then
							initConfig = {
								filetypes = { "vue" },
								init_options = {
									vue = {
										hybridMode = false,
									},
									typescript = {
										tsdk = "/usr/lib/node_modules/@vue/typescript-plugin",
									},
								},
								timeout_ms = 1000,
							}
						end
						local capabilities = require("cmp_nvim_lsp").default_capabilities()
						require("lspconfig")[server_name].setup({
							initConfig,
							capabilities = capabilities,
						})
					end,
				},
			})
		end,
	},
}
