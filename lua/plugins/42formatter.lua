-- File: /lua/plugins/42formatter.lua
return {
    "cacharle/c_formatter_42.vim",
    run = "CFormatter42",
    opts = {
        enable = false, -- Default: plugin is disabled
    },
    cond = function()
        local ok, custom = pcall(require, "custom.42formatter")
        local opts = require("plugins.42formatter").opts

        if ok and custom.modify_opts then
            opts = custom.modify_opts(opts)
        end

        -- Only load if opts.enable is true
        return opts.enable
    end,
}
