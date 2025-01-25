return {
	-- Highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		-- enabled = false,
		event = 'VeryLazy',
		config = function()
			vim.cmd('TSUpdate')
			require('nvim-treesitter.configs').setup({
				ensure_installed = { 'lua', 'markdown', 'typescript', 'javascript', 'rust', 'json', 'toml' },

				highlight = {
					enable = true,
				},

				auto_install = true,

				-- additional_vim_regex_highlighting = true,
			})
		end,
	},
}
