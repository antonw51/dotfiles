local blink_methods = {
	icon = function(ctx)
		local icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
		return icon
	end,
	highlight = function(ctx)
		local _, hi, _ = require('mini.icons').get('lsp', ctx.kind)
		vim.print(hi)
		return hi
	end,
}

return {
	-- Mason
	{ 'mason-org/mason.nvim', opts = {} },
	{
		'mason-org/mason-lspconfig.nvim',
		version = '1.*',
		opts = {
			ensure_installed = { 'lua_ls', 'rust_analyzer' },
		},
		config = function(lazy)
			local mlspconfig = require('mason-lspconfig')

			mlspconfig.setup(lazy.opts)
			mlspconfig.setup_handlers({
				vim.lsp.enable,
			})
		end,
		dependencies = {
			'mason-org/mason.nvim',
		},
	},

	{
		'Saghen/blink.cmp',
		dependencies = {
			'echasnovski/mini.icons',
		},
		version = '1.*',
		build = 'cargo build --release',
		opts = {
			keymap = {
				preset = 'default',

				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },

				['<Tab>'] = { 'accept', 'fallback' },
			},
			appearance = {
				nerd_font_variant = 'normal',
			},
			sources = {
				default = { 'lsp', 'buffer', 'path', 'omni' },
			},
			completion = {
				list = { selection = { auto_insert = false } },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 700,
				},
				ghost_text = { enabled = true },
				menu = {
					auto_show = true,
					draw = {
						columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
						components = {
							kind_icon = {
								text = blink_methods.icon,
							},
							kind = {
								text = function(ctx)
									return '(' .. ctx.kind .. ')'
								end,
								highlight = 'SpecialKey',
							},
						},
					},
				},
			},
			cmdline = {
				enabled = true,
				keymap = { preset = 'inherit' },
				sources = { 'buffer', 'cmdline' },
				completion = {
					list = { selection = { preselect = true, auto_insert = false } },
					ghost_text = { enabled = true },
					menu = {
						auto_show = true,
					},
				},
			},
			signature = { enabled = true, window = { show_documentation = true } },
		},
	},
}
