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

-- Configuration for lazy.nvim
require("lazy").setup({
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    { "nvim-telescope/telescope.nvim", tag = '0.1.2' },
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            'neovim/nvim-lspconfig',             -- Required
            'williamboman/mason.nvim',           -- Optional
            'williamboman/mason-lspconfig.nvim', -- Optional

            -- Autocompletion
            'hrsh7th/nvim-cmp',                  -- Required
            'hrsh7th/cmp-nvim-lsp',              -- Required
            'L3MON4D3/LuaSnip',                  -- Required
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-nvim-lua'
        }
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },
    "p00f/nvim-ts-rainbow",
    { 'rose-pine/neovim', name = 'rose-pine' },
    'ThePrimeagen/vim-be-good',
    "Diogo-ss/42-header.nvim",
    "christoomey/vim-tmux-navigator",
    {
        "kylechui/nvim-surround",
        version = "*", -- For stability; omit to use `main` branch for latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    "wintermute-cell/gitignore.nvim"
})

