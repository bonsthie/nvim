return {
    dir = "/home/bonsthie/Documents/code/nvim/mason-lspconfig.nvim",
	config = function()
		require("mason").setup {
			registries = {
				"lua:my-registry",
				"github:mason-org/mason-registry",
			},
		}
	end
}
