vim.opt.termguicolors = true

vim.o.background = "dark" -- or "light" for light mode

function toggle_theme()
  if vim.g.current_theme == 'gruvbox' then
    vim.cmd('colorscheme rose-pine')
    vim.g.current_theme = 'rose-pine' 
    vim.cmd[[highlight Normal guibg=NONE ctermbg=NONE]]
  else
    vim.cmd('colorscheme gruvbox')
    vim.g.current_theme = 'gruvbox' 
    vim.cmd[[highlight Normal guibg=NONE ctermbg=NONE]]
  end
end

-- Set initial theme
vim.g.current_theme = 'rose-pine'
vim.cmd('colorscheme rose-pine')
vim.cmd[[highlight Normal guibg=NONE ctermbg=NONE]]
-- Key mapping to toggle theme
vim.api.nvim_set_keymap('n', '<F5>', [[<Cmd>lua toggle_theme()<CR>]], { noremap = true, silent = true })

vim.cmd("command! ToggleTheme lua toggle_theme()")


