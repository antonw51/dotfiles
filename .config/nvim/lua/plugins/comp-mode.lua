return {
	{
		'ej-shafran/compile-mode.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'm00qek/baleia.nvim',
		},
		config = function()
			vim.api.nvim_set_hl(0, 'CompileModeInfo', { link = 'DiagnosticInfo' })
			vim.api.nvim_set_hl(0, 'CompileModeWarning', { link = 'DiagnosticWarning' })
			vim.api.nvim_set_hl(0, 'CompileModeError', { link = 'DiagnosticError' })

			vim.api.nvim_set_hl(0, 'CompileModeCommandOutput', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'CompileModeMessage', { link = 'SpellCap' })
			vim.api.nvim_set_hl(0, 'CompileModeMessageRow', { link = 'CursorLineNr' })
			vim.api.nvim_set_hl(0, 'CompileModeMessageCol', { link = 'CursorLineNr' })

			vim.g.compile_mode = {
				baleria_setup = true,
			}
		end,
	},
}
