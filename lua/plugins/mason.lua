return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup {
      registries = {
        "github:mason-org/mason-registry",
      },
    }
  end,
}
