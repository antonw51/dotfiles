return {
	-- Mason
	{ 'williamboman/mason.nvim', opts = {}, cmd = 'Mason' },
	{ 'williamboman/mason-lspconfig.nvim', opts = {} },

	-- Lsp configuration
	{ 'VonHeikemen/lsp-zero.nvim' },
	{ 'neovim/nvim-lspconfig' },

	-- Completion
	{ 'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-calc', 'L3MON4D3/LuaSnip', 'hrsh7th/cmp-nvim-lsp', 'onsails/lspkind.nvim' } },

	-- Additions
	{ 'ray-x/lsp_signature.nvim', event = 'VeryLazy', opts = {
		hint_prefix = '',
	} },

	-- Rust
	{ 'mrcjkb/rustaceanvim' },
}
