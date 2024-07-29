return {
	-- Telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<leader>ff', function() require('telescope.builtin').find_files({ show_hidden = true }) end },
			{ '<leader>fs', require('telescope.builtin').live_grep },
			{ '<leader>bb', require('telescope.builtin').buffers },
		},
	},
	{ 'nvim-lua/plenary.nvim' },

	-- Oil
	{
		'stevearc/oil.nvim',
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
		},
		lazy = false,
		keys = {
			{
				'<leader>ex',
				function()
					vim.cmd('Oil')
				end,
			},
		},
	},
}
