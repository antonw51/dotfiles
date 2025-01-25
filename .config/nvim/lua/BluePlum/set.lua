-- Tabs for indenting
vim.opt.autoindent = true
vim.g.noexpandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Folding
vim.opt.foldlevelstart = 99

vim.g.mapleader = ' '

-- Terminal
vim.g.termguicolors = true
vim.opt.shell = '/bin/fish'

-- LSP
vim.lsp.inlay_hint.enable()

-- Splitting
-- vim.cmd.set('splitbelow')
-- vim.cmd.set('splitright')
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Make text readable
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.md', '*.typ' },
	command = 'setlocal linebreak',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'help',
	command = 'setlocal linebreak',
})

vim.cmd.cnoreabbrev('grep', 'Grepper')

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Make dotfile navigation bareble
vim.api.nvim_create_user_command('Dot', 'edit ~/.config/nvim', {})
