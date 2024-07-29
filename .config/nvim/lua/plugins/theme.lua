return {
	{
		'loctvl842/monokai-pro.nvim',
		-- lazy = true,
		priority = 999,
		config = function()
			require('monokai-pro').setup({
				filter = 'spectrum',
			})
			vim.cmd.colorscheme('monokai-pro')
		end,
	},
}
