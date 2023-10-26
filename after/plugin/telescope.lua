local builtin = require('telescope.builtin')

-- Find files in the current directory
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

-- Find files in the git directory
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Grep
vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({search = vim.fn.input("Grep > ") });
end)
