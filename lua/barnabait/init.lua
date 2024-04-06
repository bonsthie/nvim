local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim exists; if not, clone it
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",  -- latest stable release
        lazypath,
    })
end

-- Prepend to the runtime path
vim.opt.rtp:prepend(lazypath)

require('barnabait.remap')
require('barnabait.set')
require("lazy").setup("plugins", {
	change_detection = {
		notify = false;
	}
})

vim.o.clipboard = "unnamedplus"
