return ({
    "ellisonleao/gruvbox.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf" },
    "folke/neodev.nvim",
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    'ThePrimeagen/vim-be-good',
    "christoomey/vim-tmux-navigator",
    {
        "kylechui/nvim-surround",
        version = "*", -- For stability; omit to use `main` branch for latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {"wintermute-cell/gitignore.nvim", run = ':Gitignore'},
	{'cacharle/c_formatter_42.vim', run = 'CFormatter42'},
	'windwp/nvim-autopairs',
	"github/copilot.vim"
})
