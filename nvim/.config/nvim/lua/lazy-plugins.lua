local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup({
    "ellisonleao/gruvbox.nvim",
    "lewis6991/gitsigns.nvim",

    "williamboman/mason.nvim",

    "neovim/nvim-lspconfig",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip"
})
