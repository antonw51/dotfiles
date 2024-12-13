vim.keymap.set('i', '<M-Up>', '<ESC>:move-2<CR>i')
vim.keymap.set('i', '<M-Down>', '<ESC>:move+<CR>i')

vim.keymap.set('n', '<C-Up>', '<C-u>zz')
vim.keymap.set('n', '<C-Down>', '<C-d>zz')

-- yank to clipboard with leader
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

vim.keymap.set('n', 'Q', '<nop>')

-- terminal
vim.keymap.set('n', '<leader>t', ':term<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')

-- nice additions
vim.keymap.set('n', '<leader>er', function()
	vim.diagnostic.open_float()
end)
vim.keymap.set('n', '<leader>l', ':e#<CR>')
-- vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>')
-- vim.keymap.set('n', '<leader>cn', ':IncRename ')

vim.keymap.set('n', '<leader>i', 'cc')
-- peek
vim.keymap.set('n', '<leader>p', vim.lsp.buf.hover)

-- Scratch pad
vim.keymap.set(
	'n',
	'<leader>s',
	':bo vs<CR>:enew<CR>:setlocal noswapfile<CR>:setlocal bufhidden=hide<CR>:setlocal buftype=nofile<CR>:set filetype=markdown<CR>:set syntax=markdown<CR>'
)

-- Help
vim.cmd.cnoreabbrev('h vert h')
vim.keymap.set('n', '<leader>h', ':h <C-r><C-w><CR>')

-- Windows
vim.keymap.set('n', '<leader>q', function()
	if vim.bo.modified then
		if Confirm('Buffer has unsaved changes; write?') then
			vim.cmd.write()
			vim.cmd.bdelete()
		else
			vim.cmd('bd!')
		end
	else
		vim.cmd.bdelete()
	end
end)

-- Comp mode
vim.keymap.set('n', '<leader>c<CR>', ':Compile<CR>')
vim.keymap.set('n', '<leader>cs', ':CompileInterrupt<CR>')

vim.keymap.set('n', '<leader>E', ':NextError<CR>')
