local M = {}

M.setup = function()
	local lspconfig = require("lspconfig")
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	lspconfig.lua_ls.setup {
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "Lua 5.1" },
				diagnostics = {
					globals = { "vim", "it", "describe", "before_each", "after_each" },
				},
			},
		},
	}
end

return M
