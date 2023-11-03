require('lazy-plugins')

require('mason').setup()
require('mason-lspconfig').setup()

require('gitsigns').setup()

require('treesitter-setup')
require('autocomplete-setup')

-- Set theme
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd.colorscheme('gruvbox-material')

-- Set more convienent number line
vim.opt.relativenumber = true
vim.opt.number = true

-- Use 4 spaces for tab
vim.opt.tabstop = 4
vim.opt.expandtab = true
