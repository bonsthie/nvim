local M = {}

M.setup = function(capabilities)
	local lspconfig = require("lspconfig")

	lspconfig.clangd.setup {
		cmd = {
			"clangd",
			"--background-index",
			"-j=12",
			"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
			"--clang-tidy",
			"--clang-tidy-checks=*",
			"--all-scopes-completion",
			"--cross-file-rename",
			"--completion-style=detailed",
			"--header-insertion-decorators",
			"--header-insertion=iwyu",
			"--pch-storage=memory",
		},
		capabilities = capabilities,
		filetypes = { "c", "cpp", "objc", "objcpp", "tpp" },
		on_attach = function(_, bufnr)
			M.new_keymap(bufnr, "n", "<C-q>", M.quick_fix_first)
		end,
	}
end

M.quick_fix_first = function()
	vim.lsp.buf.code_action({
		apply = true
	})
end

M.new_keymap = function(bufnr, mode, shortcut, func)
	vim.api.nvim_buf_set_keymap(bufnr, mode, shortcut, "", {
		noremap = true,
		silent = true,
		callback = func
	})
end

return M
