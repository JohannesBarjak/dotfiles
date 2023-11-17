-- Configure treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed =
        { "haskell"
        , "rust", "c", "nasm"
        , "python", "lua"
        , "vim", "vimdoc"
        , "query", "regex"
        , "ini", "toml"
        , "gdscript"
        },

    highlight =
        { enable = true }
}
