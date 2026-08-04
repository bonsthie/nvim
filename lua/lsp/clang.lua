local M = {}

M.setup = function(capabilities)
	local clangd = vim.fn.exepath("clangd")
	local clangxx = vim.fn.exepath("clang++")

	vim.lsp.config("clangd", {
		cmd = {
			clangd,
			"--background-index",
			"-j=12",
			"--query-driver=" .. clangxx,
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
		on_attach = function(client, bufnr)
			M.new_keymap(bufnr, "n", "<C-q>", M.quick_fix_first)
			M.create_clangd_commands(client, bufnr)
		end,
	})

	vim.lsp.enable("clangd")
end

M.quick_fix_first = function()
	vim.lsp.buf.code_action({
		apply = true
	})
end

M.switch_source_header = function(client, bufnr)
	local method_name = "textDocument/switchSourceHeader"

	if not client or not client:supports_method(method_name) then
		vim.notify(("method %s is not supported by any servers active on the current buffer"):format(method_name))
		return
	end

	local params = vim.lsp.util.make_text_document_params(bufnr)

	client:request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end

		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end

		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end

M.create_clangd_commands = function(client, bufnr)
	local switch_source_header = function()
		M.switch_source_header(client, bufnr)
	end

	vim.api.nvim_buf_create_user_command(bufnr, "ClangSwitchHeader", switch_source_header, {
		desc = "Switch between source/header",
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
