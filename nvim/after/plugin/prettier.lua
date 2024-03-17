vim.keymap.set('n', '<leader>F', function()
    vim.lsp.buf.format()
    require('../BluePlum.set')
end)
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        vim.lsp.buf.format()

        require('../BluePlum.set')
    end
})

