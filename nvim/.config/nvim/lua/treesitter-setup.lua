-- Configure treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = { "haskell" },
    highlight =
        { enable = true }
}
