local set = vim.keymap.set

set('i', '<M-Up>', '<ESC>:move-2<CR>i')
set('i', '<M-Down>', '<ESC>:move+<CR>i')

set('n', '<C-Up>', '<C-u>zz')
set('n', '<C-Down>', '<C-d>zz')

-- yank to clipboard with leader
set('n', '<leader>y', '"+y')
set('v', '<leader>y', '"+y')

set('n', 'Q', '<nop>')

-- terminal
-- set('n', '<leader>t', ':split<CR>:term<CR>')
OpenTerminal = nil
PreviousBuffer = -1
set('n', '<leader>t', function()
	if vim.api.nvim_get_current_buf() == OpenTerminal and PreviousBuffer ~= -1 then
		vim.api.nvim_set_current_buf(PreviousBuffer)
		PreviousBuffer = -1
		return
	end

	PreviousBuffer = vim.api.nvim_get_current_buf()
	if OpenTerminal ~= nil then
		vim.api.nvim_set_current_buf(OpenTerminal)
	else
		vim.cmd.term()
		OpenTerminal = vim.api.nvim_get_current_buf()
		vim.api.nvim_create_autocmd({ 'BufDelete' }, {
			callback = function(args)
				if args.buf == OpenTerminal then
					OpenTerminal = nil
				end
			end,
		})
	end
end)
set('t', '<ESC>', '<C-\\><C-n>')

-- nice additions
set('n', '<leader>er', function()
	vim.diagnostic.open_float()
end)
set('n', '<leader>l', ':e#<CR>')
-- set('n', '<leader>ca', ':CodeActionMenu<CR>')
-- set('n', '<leader>cn', ':IncRename ')

set('n', '<leader>i', 'cc')
-- peek
set('n', '<leader>p', vim.lsp.buf.hover)

-- Scratch pad
set(
	'n',
	'<leader>s',
	':bo vs<CR>:enew<CR>:setlocal noswapfile<CR>:setlocal bufhidden=hide<CR>:setlocal buftype=nofile<CR>:set filetype=markdown<CR>:set syntax=markdown<CR>'
)

-- Help
-- vim.cmd.cnoreabbrev('h vert h')
-- set('n', '<leader>h', ':h <C-r><C-w><CR>')

-- Comp mode
set('n', '<leader>c<CR>', ':Compile<CR>')
set('n', '<leader>cs', ':CompileInterrupt<CR>')

set('n', '<leader>E', ':NextError<CR>')

-- Windows
set('n', '<M-q>', '<C-w>q')
set('n', '<M-left>', '<C-w><left>')
set('n', '<M-right>', '<C-w><right>')
set('n', '<M-up>', '<C-w><up>')
set('n', '<M-down>', '<C-w><down>')

set('n', '<M-S-right>', '<C-w>t<C-w>H')

Fullscreen = false
set('n', '<M-f>', function()
	if Fullscreen then
		print('full screen')
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>_<C-w>|', true, false, true), 'm', false)
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-w>=', true, false, true), 'm', false)
	end
	Fullscreen = not Fullscreen
end)

-- Generic
set('n', '<leader>q', ':bd!<CR>')
