-- random stuff
return ({
	{
		dir = "/nfs/homes/babonnet/.config/nvim/lua/test_plugin/fastclass.nvim",
		config = function()
			require("fastclass").setup({
				header = false,
				clangformat = true,
				header_extension = ".h",
				pragma_once_header = true,
			})
		end
	},
	{ "folke/neoconf.nvim",             cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	'ThePrimeagen/vim-be-good',
	"christoomey/vim-tmux-navigator",
	{ "wintermute-cell/gitignore.nvim", run = ':Gitignore' },
	{ 'cacharle/c_formatter_42.vim',    run = 'CFormatter42' },
	'terrortylor/nvim-comment',
})
