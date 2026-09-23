return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Define the custom on_attach function
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Load default nvim-tree mappings first
			api.config.mappings.default_on_attach(bufnr)

			-- Map 'X' to run xdg-open on the hovered file
			vim.keymap.set("n", "X", function()
				local node = api.tree.get_node_under_cursor()
				if node and node.absolute_path then
					-- Runs asynchronously so Neovim doesn't freeze
					vim.fn.jobstart({ "xdg-open", node.absolute_path }, { detach = true })
				end
			end, opts("Open with xdg-open"))
		end

		-- Pass the function into setup
		require("nvim-tree").setup({
			on_attach = my_on_attach,
		})
	end
}

