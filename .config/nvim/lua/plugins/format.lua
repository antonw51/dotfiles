return {
	{
		'tjex/formatter.nvim',
		branch = 'fix-305-index-out-of-bounds',
		config = function()
			local util = require('formatter.util')

			local function prettier()
				return {
					exe = 'prettier',
					args = {
						'--config-precedence',
						'prefer-file',
						'--single-quote',
						'--use-tabs',
						'--trailing-comma',
						'es5',
						'--bracket-same-line',
						'--insert-pragma',
						'--stdin-filepath',
						vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),
					},
					stdin = true,
				}
			end

			require('formatter').setup({
				filetype = {
					javascript = {
						prettier,
					},
					typescript = {
						prettier,
					},
					markdown = {
						prettier,
					},
					css = {
						prettier,
					},
					json = {
						prettier,
					},
					html = {
						prettier,
					},
					scss = {
						prettier,
					},

					lua = {
						function()
							return {
								exe = 'stylua',
								args = {
									'--indent-type',
									'Tabs',
									'--line-endings',
									'Unix',
									'--quote-style',
									'AutoPreferSingle',
									'--column-width',
									vim.api.nvim_command_output('echo &columns'),
									'-',
								},
								stdin = true,
							}
						end,
					},
					['*'] = {
						function()
							if vim.lsp.buf.formatting then
								vim.lsp.buf.format()
							end
						end,
					},
				},
			})

			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd
			augroup('__formatter__', {
				clear = true,
			})
			autocmd('BufWritePost', {
				group = '__formatter__',
				command = ':FormatWrite',
			})
		end,
	},
}
