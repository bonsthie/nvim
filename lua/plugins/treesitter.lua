return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ':TSUpdate', -- Use `build` instead of `run` for Lazy.nvim
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "lua" },
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = { enable = true },
            }
        end,
    },
}
