--- @class Lazy
--- @field setup fun(opts: table)

local M = {}

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

--- @nodiscard
--- @return Lazy?
function M.bootstrap()
	--- @type { fs_stat: fun(path: string): boolean }
	local fs = vim.uv or vim.loop
	if fs.fs_stat(lazypath) then
		vim.opt.rtp:prepend(lazypath)
		return require('lazy')
	end

	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
		}, true, {})
		return nil
	end

	return require('lazy')
end

return M
