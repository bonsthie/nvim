return {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
        theme = 'rose-pine', -- Default theme
		background = "dark"
    },
    config = function(_, opts)
        vim.opt.termguicolors = true
        vim.o.background = opts.background
        local theme = opts.theme or 'rose-pine' -- Use override or default
        vim.g.current_theme = theme
        vim.cmd('colorscheme ' .. theme)
        vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
    end
}
