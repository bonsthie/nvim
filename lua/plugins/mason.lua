return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup {
      PATH = "append",
      registries = {
        "github:mason-org/mason-registry",
      },
    }
  end,
}
