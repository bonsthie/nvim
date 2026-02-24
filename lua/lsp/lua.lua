local M = {}

function M.setup(capabilities)
	local lspconfig = require("lspconfig")

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = {
					globals = { "vim", "it", "describe", "before_each", "after_each" },
				},
				workspace = {
					checkThirdParty = false,
				},
			},
		},
	})
end

return M
