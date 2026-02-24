local M = {}

-- Configure Lazy.nvim to load plugins
function M.setup()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	-- Check if Lazy.nvim exists; if not, clone it
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git", "clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end

	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup({
		spec = {
			{ import = "plugins" }, -- Load base plugins
			{ import = "custom/plugins" }, -- Load custom plugins
		},
		defaults = { lazy = false },
		change_detection = { notify = false },
	})

	-- require("barnabait.override").load_plugins()
end

return M
