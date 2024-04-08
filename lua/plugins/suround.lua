return ({
	"kylechui/nvim-surround",
	version = "*",     -- For stability; omit to use `main` branch for latest features
	config = function()
		require("nvim-surround").setup({})
	end
})
