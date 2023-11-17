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
    "neovim/nvim-lspconfig",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "L3MON4D3/LuaSnip",

    "sainnhe/gruvbox-material",
    "lewis6991/gitsigns.nvim",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",

    "ray-x/cmp-treesitter",
    "dmitmel/cmp-digraphs",
    "saadparwaiz1/cmp_luasnip",

    { "nvim-neo-tree/neo-tree.nvim"
    , branch = "v3.x"
    , dependencies =
        { "nvim-lua/plenary.nvim"
        , "nvim-tree/nvim-web-devicons"
        , "MunifTanjim/nui.nvim"
        , "3rd/image.nvim"
        }
    },

    { 'nvim-lualine/lualine.nvim'
    , dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    { 'akinsho/bufferline.nvim'
    , version = "*"
    , dependencies = 'nvim-tree/nvim-web-devicons'
    }
})
