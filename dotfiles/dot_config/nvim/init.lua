require('nvim-treesitter.configs').setup { highlight = { enable = true }}
require('autocomplete-setup')

require('gitsigns').setup()
require('neogit').setup()

vim.opt.background = 'dark'
vim.cmd.colorscheme('gruvbox')

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.smartindent = true
vim.opt.expandtab = true
