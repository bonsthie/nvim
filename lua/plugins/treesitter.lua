return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = { "lua", "c", "markdown" }

            require("nvim-treesitter").setup()
            require("nvim-treesitter").install(parsers)

            local filetypes = {}
            for _, parser in ipairs(parsers) do
                for _, filetype in ipairs(vim.treesitter.language.get_filetypes(parser)) do
                    table.insert(filetypes, filetype)
                end
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function(event)
                    pcall(vim.treesitter.start, event.buf)
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/playground",
        cmd = "TSPlaygroundToggle",
        config = function()
        end,
    }
}
