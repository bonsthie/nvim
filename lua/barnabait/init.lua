
require("barnabait.remap")
require("barnabait.set")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text on yank",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.o.clipboard = "unnamedplus"

require("barnabait.lazy").setup()
