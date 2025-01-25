return {
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'stevearc/dressing.nvim', opts = {} },
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('todo-comments').setup()
		end,
	},
	{ 'norcalli/nvim-colorizer.lua', opts = {} },
	{
		'OXY2DEV/markview.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		ft = 'markdown',
		config = function()
			require('markview')
			vim.api.nvim_set_hl(0, 'MarkviewLayer', { fg = '#2a2a2a', bg = '#373737' })
		end,
	},
	{
		'sphamba/smear-cursor.nvim',
		opts = {
			time_interval = 10,
			legacy_computing_symbols_support = true,
			cursor_color = '#fcdc34',
		},
	},
}
