local lsp = require('lsp-zero')

lsp.preset('recommended')

-- NVIM-CMP

local cmp_kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}


local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),
    snippet = {
        expand = function(args)
            local luasnip = require('luasnip')
            if not luasnip then
                return
            end
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'calc' }
    },
    formatting = {
        fields = { 'abbr', 'kind' },

        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },

        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s %s ', cmp_kind_icons[vim_item.kind], vim_item.kind)

            return vim_item
        end


        -- format = function(entry, item)
        --     local menu_icon = {
        --         nvim_lsp = 'λ',
        --         luasnip = '⋗',
        --         buffer = 'Ω',
        --         path = '🖫',
        --     }


        --     item.menu = menu_icon[entry.source.name]
        --     return item
        -- end
    }
})

vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })

vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })

vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })

vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })

vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

--LSP

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- lsp.default_keymaps({buffer = bufnr})
    require("inlay-hints").on_attach(client, bufnr)

    -- goto defeniition
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp.default_setup,
    },
})
