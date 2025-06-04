return {
	"cohama/lexima.vim",
	config = function()
		vim.cmd([[
			let g:lexima_enable_basic_rules = 1
			let g:lexima_enable_newline_rules = 1
			let g:lexima_enable_endwise_rule = 1
		]])
	end
}
