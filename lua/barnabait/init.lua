require('barnabait.remap')
require('barnabait.set')
require('barnabait.lazy')

vim.o.clipboard = "unnamedplus"
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap("n", "<THE KEYBINDING YOU WANT>", ":header42<CR>",opts)
