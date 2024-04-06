return {
    "williamboman/mason.nvim",
	config = function()
		require("mason").setup {
			registries = {
				"lua:my-registry",
				"github:mason-org/mason-registry",
			},
		}
	end
}
