return {
	'rose-pine/neovim',
	name = 'rose-pine',
	config = function()
		vim.opt.termguicolors = true
		vim.o.background = "dark" -- or "light" for light mode
		-- Set initial theme
		vim.g.current_theme = 'rose-pine'
		vim.cmd('colorscheme rose-pine')
		vim.cmd [[highlight Normal guibg=NONE ctermbg=NONE]]
	end
}
