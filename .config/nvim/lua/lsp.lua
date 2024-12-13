local required = { 'mason', 'mason-lspconfig', 'lspconfig', 'lsp-zero', 'cmp' }
local ready = true

vim.cmd.echohl('WarningMsg')

for _, module in ipairs(required) do
	local ok, _ = pcall(require, module)
	if not ok then
		ready = false
		vim.cmd.echo('"Module \'' .. module .. "' isn't present!\"")
	end
end

if not ready then
	vim.cmd.echo('"LSP disabled!"')
	vim.cmd.echohl('None')
	return
end

vim.cmd.echohl('None')

local zero = require('lsp-zero')

zero.preset('recommended')
require('mason').setup({})

local settings = {
	['lua_ls'] = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			workspace = {
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
}

require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
	},
	handlers = {
		-- zero.default_setup,
		function(name)
			require('lspconfig')[name].setup({
				settings = settings[name] or {},
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
			})
		end,
	},
})

zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
end)

-- #region CMP

local cmp_kind_icons = {
	Text = '',
	Method = '󰆧',
	Function = '󰊕',
	Constructor = '',
	Field = '󰇽',
	Variable = '󰂡',
	Class = '󰠱',
	Interface = '',
	Module = '',
	Property = '󰜢',
	Unit = '',
	Value = '󰎠',
	Enum = '',
	Keyword = '󰌋',
	Snippet = '',
	Color = '󰏘',
	File = '󰈙',
	Reference = '',
	Folder = '󰉋',
	EnumMember = '',
	Constant = '󰏿',
	Struct = '',
	Event = '',
	Operator = '󰆕',
	TypeParameter = '󰅲',
}

local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
	}),
	snippet = {
		expand = function(args)
			local luasnip = require('luasnip')
			if not luasnip then
				return
			end
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'calc' },
	},
	window = {
		completion = {
			winhighlight = 'Normal:Pmeny,FloatBorder:Pmenu,Search:None',
			col_offset = -3,
			side_padding = 0,
		},
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },

		format = function(entry, vim_item)
			local kind = require('lspkind').cmp_format({ mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, '%s', { trimempty = true })
			kind.kind = ' ' .. (strings[1] or '') .. ' '
			kind.menu = '    (' .. (strings[2] or '') .. ')'

			return kind
		end,
	},
})

-- #region Highlight groups

-- Customization for Pmenu

vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282C34', fg = 'NONE' })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { fg = '#7E8294', bg = 'NONE', strikethrough = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = '#82AAFF', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#82AAFF', bg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#C792EA', bg = 'NONE', italic = true })

vim.api.nvim_set_hl(0, 'CmpItemKindField', { fg = '#EED8DA', bg = '#B5585F' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = '#EED8DA', bg = '#B5585F' })
vim.api.nvim_set_hl(0, 'CmpItemKindEvent', { fg = '#EED8DA', bg = '#B5585F' })

vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = '#C3E88D', bg = '#9FBD73' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = '#C3E88D', bg = '#9FBD73' })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = '#C3E88D', bg = '#9FBD73' })

vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = '#FFE082', bg = '#D4BB6C' })
vim.api.nvim_set_hl(0, 'CmpItemKindConstructor', { fg = '#FFE082', bg = '#D4BB6C' })
vim.api.nvim_set_hl(0, 'CmpItemKindReference', { fg = '#FFE082', bg = '#D4BB6C' })

vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = '#EADFF0', bg = '#A377BF' })
vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = '#EADFF0', bg = '#A377BF' })
vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = '#EADFF0', bg = '#A377BF' })
vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = '#EADFF0', bg = '#A377BF' })
vim.api.nvim_set_hl(0, 'CmpItemKindOperator', { fg = '#EADFF0', bg = '#A377BF' })

vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = '#C5CDD9', bg = '#7E8294' })
vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = '#C5CDD9', bg = '#7E8294' })

vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = '#F5EBD9', bg = '#D4A959' })
vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = '#F5EBD9', bg = '#D4A959' })
vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = '#F5EBD9', bg = '#D4A959' })

vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = '#DDE5F5', bg = '#6C8ED4' })
vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = '#DDE5F5', bg = '#6C8ED4' })
vim.api.nvim_set_hl(0, 'CmpItemKindEnumMember', { fg = '#DDE5F5', bg = '#6C8ED4' })

vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = '#D8EEEB', bg = '#58B5A8' })
vim.api.nvim_set_hl(0, 'CmpItemKindColor', { fg = '#D8EEEB', bg = '#58B5A8' })
vim.api.nvim_set_hl(0, 'CmpItemKindTypeParameter', { fg = '#D8EEEB', bg = '#58B5A8' })

-- #endregion

-- #endregion

vim.diagnostic.config({
	severity_sort = true,
})
