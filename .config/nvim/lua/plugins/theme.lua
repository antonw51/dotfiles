return {
	{
		'blazkowolf/gruber-darker.nvim',
		priority = 999,
		config = function()
			vim.cmd.colorscheme('gruber-darker')
		end,
		enabled = false,
	},
	{
		'nyoom-engineering/oxocarbon.nvim',
		priority = 999,
		config = function()
			vim.cmd.colorscheme('oxocarbon')

			local function hi(c, link)
				vim.api.nvim_set_hl(0, 'BlinkCmpKind' .. c, { link = link })
			end

			hi('Text', 'Identifier')
			hi('Method', '@function.builtin')
			hi('Function', 'Function')
			hi('Constructor', '@character')
			hi('Field', '@property')
			hi('Variable', '@label')
			hi('Class', 'Todo')
			hi('Interface', 'Type')
			hi('Module', 'Macro')
			hi('Property', '@property')
			hi('Unit', 'Type')
			hi('Value', 'Number')
			hi('Enum', 'String')
			hi('Keyword', 'Identifier')
			hi('Snippet', 'Identifier')
			hi('Color', 'Identifier')
			hi('File', 'Identifier')
			hi('Folder', 'identifier')
			hi('Reference', 'Identifier')
			hi('EnumMember', 'String')
			hi('Constant', '@constant.builtin')
			hi('Struct', 'Type')
			hi('Event', '@constant')
			hi('Operator', 'Structure')
			hi('TypeParameter', 'Type')

			vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { link = 'IncSearch' })
		end,
	},
}
