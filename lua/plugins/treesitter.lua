return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")
            local pre_installed_parsers = { "lua", "c", "markdown" }
            local auto_install_exclude = {
                gitcommit = true,
            }
            local config_augroup = vim.api.nvim_create_augroup("treesitter_config", { clear = true })

            treesitter.setup()
            treesitter.install(pre_installed_parsers)

            vim.api.nvim_create_autocmd("FileType", {
                group = config_augroup,
                pattern = "*",
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or auto_install_exclude[lang] then
                        return
                    end

                    if vim.list_contains(treesitter.get_available(), lang) then
                        if not vim.list_contains(treesitter.get_installed("parsers"), lang)
                            and not vim.list_contains(pre_installed_parsers, lang) then
                            treesitter.install(lang):wait()
                        end

                        if pcall(vim.treesitter.start, args.buf, lang) then
                            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                        end
                    end
                end,
                desc = "Enable nvim-treesitter and install parser if not installed",
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
