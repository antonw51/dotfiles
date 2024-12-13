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
		config = function()
			require('actions-preview').setup({})
			vim.keymap.set('n', '<leader>ca', require('actions-preview').code_actions)
		end,
	},
}
