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

require('42-exam.remap')
require('42-exam.set')
require("lazy").setup("plugins", {
	change_detection = {
		notify = false;
	}
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- clipbaord set to the pc default "*
vim.o.clipboard = "unnamedplus"
