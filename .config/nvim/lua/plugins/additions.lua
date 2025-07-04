return {
	{
		'smjonas/inc-rename.nvim',
		keys = { {
			'<leader>cn',
			':IncRename ',
		} },
		config = function()
			require('inc_rename').setup({})
		end,
	},
	{
		'aznhe21/actions-preview.nvim',
		keys = { {
			'<leader>ca',
			function()
				require('actions-preview').code_actions()
			end,
		} },
		opts = {},
		-- config = function()
		-- 	require('actions-preview').setup({})
		-- 	vim.keymap.set('n', '<leader>ca', require('actions-preview').code_actions)
		-- end,
	},
	{
		'vyfor/cord.nvim',
		event = 'VeryLazy',
		build = ':Cord update',
		opts = {},
	},
	{
		'tpope/vim-fugitive',
		cmd = { 'Git' },
	},
	{
		'mhinz/vim-grepper',
		cmd = { 'GrepperRg' },
		opts = {},
	},
}
