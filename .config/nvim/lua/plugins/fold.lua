return {
	{
        'kevinhwang91/nvim-ufo',
        dependencies = {
            {
                'kevinhwang91/promise-async',
            },
        },
        config = function()
            -- Implement custom marker provider.
            local CustomMarkerProvider = {}

            function CustomMarkerProvider.getFolds(bufnr)
                local buf = require('ufo.bufmanager'):get(bufnr)
                if not buf then
                    return
                end

                local openRegex = '#region'
                local closeRegex = '#endregion'

                local summaryRegx = openRegex .. '%s*(.*)'

                local ranges = {}
                local stack = {}
                local lines = buf:lines(1, -1)

                for lnum, line in ipairs(lines) do
                    -- Check for start marker
                    if line:match(openRegex) then
                        table.insert(stack, lnum)
                        -- Check for end marker
                    elseif line:match(closeRegex) then
                        local startLnum = table.remove(stack)
                        if startLnum then
                            local summary = lines[startLnum]:match(summaryRegx)
                            table.insert(ranges, require('ufo.model.foldingrange').new(startLnum - 1, lnum - 1, summary))
                        end
                    end
                end

                return ranges
            end

            local function customizeSelector(bufnr)
                local ranges = CustomMarkerProvider.getFolds(bufnr)
                local maybe_additional_ranges = require('ufo').getFolds(bufnr, 'treesitter')
                if next(maybe_additional_ranges) ~= nil then
                    ranges = vim.list_extend(ranges, maybe_additional_ranges)
                else
                    ranges = vim.list_extend(ranges, require('ufo').getFolds(bufnr, 'indent'))
                end
                return ranges
            end

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return customizeSelector
                end,
            })
        end,
    },
}
