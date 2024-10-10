function Ask(msg)
	vim.cmd.echohl('Question')
	vim.cmd.echo('"' .. msg .. '"')
	vim.cmd.echohl()
end

function Confirm(msg)
	Ask(msg .. ' [Y/n] ')

	local answer = vim.fn.getchar()
	return answer ~= 110 and answer ~= 27 and answer ~= 37 -- 'n', <ESC>, <SPACE>
end

function Input(prompt, last)
	local buffer = ''
	while true do
		vim.cmd('redraw | echo')
		vim.api.nvim_echo({
			{ prompt, 'Question' },
			last and { last, 'Visual' } or { buffer, 'Normal' },
		}, false, {})

		local character = vim.fn.getchar()
		if pcall(function(char)
			if vim.fn.keytrans(char) ~= '<BS>' then
				error()
			end
		end, character) then
			last = nil
			buffer = vim.fn.slice(buffer, 0, -1)
		elseif character == 27 then
			vim.cmd('redraw | echo')
			return nil
		elseif character == 13 then
			return last or buffer
		elseif
			(character == 32 or pcall(function(char)
				if vim.fn.keytrans(char) ~= '<Right>' then
					error()
				end
			end, character)) and last
		then
			buffer = last
			if character == 32 then
				buffer = buffer .. ' '
			end
			last = nil
		else
			last = nil
			buffer = buffer .. vim.fn.nr2char(character)
		end
	end
end
