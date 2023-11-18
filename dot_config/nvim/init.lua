require('lazy-plugins')

require('mason').setup()
require('mason-lspconfig').setup()

require('gitsigns').setup()

require('treesitter-setup')
require('autocomplete-setup')

require('lualine').setup ({ options = { theme = 'gruvbox-material' }})

-- According to its documentation, bufferline should be loaded after setting 'termguicolors'
vim.opt.termguicolors = true

require('bufferline').setup (
    { options =
        { diagnostics = "nvim_lsp"
        , separator_style = "slant"
        }
    })

-- Set theme
vim.opt.background = 'dark'
vim.cmd.colorscheme('gruvbox-material')

-- Set number line
vim.opt.relativenumber = true
vim.opt.number = true

-- Set indent settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
