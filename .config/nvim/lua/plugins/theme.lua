return {
	{
		'blazkowolf/gruber-darker.nvim',
		priority = 999,
		config = function()
			-- require('gruber-darker').setup()
			vim.cmd.colorscheme('gruber-darker')
		end,
	},
}
