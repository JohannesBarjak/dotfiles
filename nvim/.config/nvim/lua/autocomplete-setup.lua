-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },

    window = {},

    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip ~= nil and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip ~= nil and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
               fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources ({
        { name = 'nvim_lsp'   },
        { name = 'luasnip'    },
        { name = 'buffer'     },
        { name = 'treesitter' }
        })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lsp agnostic config
require('lspconfig')['hls'].setup {
    capabilities = capabilities
}

require('lspconfig').hls.setup {
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
