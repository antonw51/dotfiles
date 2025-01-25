return {
	-- Mason
	{ 'williamboman/mason.nvim', opts = {}, cmd = 'Mason', event = 'VeryLazy' },
	{ 'williamboman/mason-lspconfig.nvim', opts = {}, event = 'VeryLazy' },

	-- Lsp configuration
	{ 'VonHeikemen/lsp-zero.nvim' },
	{ 'neovim/nvim-lspconfig' },

	-- Completion
	{
		'hrsh7th/nvim-cmp',
		event = 'VeryLazy',
		dependencies = {
			'hrsh7th/cmp-calc',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-buffer',
			'L3MON4D3/LuaSnip',
			'hrsh7th/cmp-nvim-lsp',
			'onsails/lspkind.nvim',
		},
	},

	-- Additions
	{
		'ray-x/lsp_signature.nvim',
		event = 'VeryLazy',
		opts = {
			hint_prefix = '',
		},
	},

	-- Rust
	-- { 'mrcjkb/rustaceanvim' },
}
