local M = {
	interupt = false,
}

M.Keys = {
	enter = '<CR>',
	tab = '<Tab>',
	backspace = '<BS>',
	escape = '<Esc>',

	-- if await_key().is_arrow
	-- if key == Keys.left
	left = { is_arrow = true, this = '<Left>' },
	right = { is_arrow = true, this = '<Right>' },
	up = { is_arrow = true, this = '<Up>' },
	down = { is_arrow = true, this = '<Down>' },
}

function M.await_key()
	-- local char = vim.fn.getchar()
	local char = vim.fn.getchar()
	local num = vim.fn.nr2char(char)
	local key = vim.fn.keytrans(num)
	-- vim.print(char, num, key, key == '<BS>')

	-- Some special keys work weird..
	local is_key = function(key)
		return pcall(function(char)
			if vim.fn.keytrans(char) ~= key then
				error()
			end
		end, char)
	end

	if is_key('<BS>') then
		return M.Keys.backspace
	elseif is_key('<Left>') then
		return M.Keys.left
	elseif is_key('<Right>') then
		return M.Keys.right
	elseif is_key('<Up>') then
		return M.Keys.up
	elseif is_key('<Down>') then
		return M.Keys.down
	elseif key == '<Space>' then
		return ' '
	elseif key == '<Lt>' then
		return '<'
	elseif key == '<Gt>' then
		return '>'
	end

	return key
end

-- vim.print(vim.fn.getcompletion('ech', 'command'))
-- vim.fn.getchar()

local function refresh_completions(pattern, kind)
	local completions = vim.fn.getcompletion(pattern, kind)

	if #completions > 25 then
		local new = {}
		for i = 1, 25 do
			new[i] = completions[i]
		end
		new[#new + 1] = '...' -- Append truncation indicator
		return new
	end

	return completions
end

local function format_completions(completions)
	local formatted = { { '{', 'Normal' } }
	for i = 1, #completions do
		table.insert(formatted, { completions[i], i == 1 and 'CursorLineNr' or 'Normal' })
		if i ~= #completions then
			table.insert(formatted, { ', ', 'Normal' })
		end
	end
	table.insert(formatted, { '}', 'Normal' })
	return formatted
end

local function input(prompt, default, completion)
	vim.validate({
		prompt = { prompt, 'table' },
		default = { default, { 'string', 'nil' } },
		completion = { completion, { 'string', 'nil' } },
	})
	local using_default = default ~= nil
	local typed = default or ''

	local completions = {}

	local cursor = 0

	while true do
		if completion ~= nil then
			completions = refresh_completions(typed, completion)
		end

		vim.cmd('echo | redraw')
		vim.api.nvim_echo({
			unpack(prompt),
			{ string.sub(typed, 0, cursor), using_default and 'Visual' or 'Normal' },
			cursor == #typed and { '█', 'CursorLineNr' } or { string.sub(typed, cursor + 1, cursor + 1), 'Search' },
			{ string.sub(typed, cursor + 2), 'Normal' },
			unpack(#completions > 0 and format_completions(completions) or {}),
		}, false, {})
		local input = M.await_key()

		if input == M.Keys.enter or input == M.Keys.escape then
			vim.cmd('echo | redraw')
			return input == M.Keys.enter, typed
		elseif input == M.Keys.backspace then
			if cursor <= 0 then
				goto continue
			end
			typed = string.sub(typed, 0, cursor - 1) .. string.sub(typed, cursor + 1)
			cursor = cursor - 1
			goto continue
		elseif input.is_arrow then
			if input == M.Keys.left then
				if cursor > 0 then
					cursor = cursor - 1
				end
			elseif input == M.Keys.right then
				if cursor < #typed then
					cursor = cursor + 1
				end
			end
			-- vim.api.nvim_win_set_cursor(0, { 1, 10 })
			goto continue
		elseif input == M.Keys.tab then
			if #completions == 0 then
				goto continue
			end
			cursor = #typed

			local insert = completions[1]
			local offset = #typed

			-- Find the largest overlapping slice
			while offset > 0 and not vim.startswith(insert, string.sub(typed, -offset)) do
				offset = offset - 1
			end

			-- Replace `typed` with the completion
			typed = string.sub(typed, 1, #typed - offset) .. insert .. ' '
			cursor = #typed
			goto continue
		end

		typed = string.sub(typed, 0, cursor) .. input .. string.sub(typed, cursor + 1)
		cursor = cursor + 1

		::continue::
	end
end

-- Safe wrapper for hiding the cursor (also captures <C-c>)
function M.input(prompt, default, completion)
	local hl = vim.api.nvim_get_hl(0, { name = 'Cursor' })

	hl.blend = 100
	vim.api.nvim_set_hl(0, 'Cursor', hl)

	-- local result, success, typed = pcall(input, prompt, defaut, completion)
	local success, typed = input(prompt, default, completion)
	vim.cmd('echo | redraw')

	hl.blend = 0
	vim.api.nvim_set_hl(0, 'Cursor', hl)

	return success, typed, not result
end

---@param opts? table
---@param on_confirm function
vim.ui.input = function(opts, on_confirm)
	vim.validate({
		opts = { opts, 'table' },
		on_confirm = { on_confirm, 'function' },
	})

	opts = opts or {}
	on_confirm = on_confirm or function() end

	vim.validate({
		-- Also supports list of HlGroup tuples
		prompt = { opts.prompt, { 'table', 'string', 'nil' } },

		default = { opts.default, { 'string', 'nil' } },
		completion = { opts.completion, { 'string', 'nil' } },

		highlight = {
			opts.highlight,
			function(it)
				return it == nil
			end,
			'nil (not supported)',
		},
	})

	local prompt = opts.prompt or { { 'Enter input > ', 'Question' } }
	if type(prompt) == 'string' then
		-- Strip invalid characters
		prompt = vim.trim(prompt)

		local is_alpha = function(char)
			local num = vim.fn.char2nr(char)
			return (num >= 65 and num <= 90) or (num >= 97 and num <= 122)
		end

		local last = string.sub(prompt, #prompt)
		while not is_alpha(last) do
			prompt = string.sub(prompt, 0, #prompt - 1)
			prompt = vim.trim(prompt)
			last = string.sub(prompt, #prompt)
		end

		prompt = { { prompt .. ' > ', 'Question' } }
	end

	local finished, typed, interrupted = M.input(prompt, opts.default, opts.completion)
	if interrupted then
		return
	end
	on_confirm(finished and typed or nil)
end

-- vim.ui.input({ completion = 'cmdline' }, function(a)
-- 	vim.print(a)
-- end)

-- vim.keymap.set('n', ';', function()
-- 	vim.ui.input({ prompt = { { ':', 'Normal' } }, completion = 'cmdline' }, function(command)
-- 		vim.print(command)
-- 		if command then
-- 			vim.cmd(command)
-- 		end
-- 	end)
-- end)
-- add cmdheight to the input function

return M
