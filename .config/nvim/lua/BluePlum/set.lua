-- Tabs for indenting
vim.opt.autoindent = true
vim.g.noexpandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Folding
vim.opt.foldlevelstart = 99

vim.g.mapleader = ' '

-- Terminal
vim.g.termguicolors = true
vim.g.terminal_emulator = 'kitty'

-- LSP
vim.lsp.inlay_hint.enable()
