if not vim.g.neovide then
	return
end

vim.o.guifont = 'Jetbrains Mono:h17'

vim.g.neovide_underline_stroke_scale = 2.0
vim.g.neovide_theme = 'dark'
vim.g.neovide_refresh_rate_idle = 10
vim.g.neovide_transparency = 0.6

-- Scroll
vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_scroll_animation_far_lines = 50

-- Cursor
vim.g.neovide_cursor_animation_length = 0.03
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_cursor_smooth_blink = true
vim.cmd.set('guicursor=i-v-c:blinkwait400-blinkoff350-blinkon250,i-ci-ve:ver25,r-cr:hor20,o:hor20')

-- Pasting
vim.keymap.set('i', '<SC-v>', '<C-r>+')
vim.keymap.set('n', '<SC-v>', '"+p')
