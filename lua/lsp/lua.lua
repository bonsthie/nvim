local M = {}

function M.setup(capabilities)
	vim.lsp.config("lua_ls", {
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

	vim.lsp.enable("lua_ls")
end

return M
