return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- UI for LSP progress
		require("fidget").setup({})

		-- mason core + ensure parsers/installers
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "clangd" },
		})

		-- ← NEW in mason-lspconfig v1.18+: split out handlers here
		require("mason-lspconfig").setup_handlers({
			-- default handler for any server not otherwise specified
			function(server_name)
				require("lspconfig")[server_name].setup {
					capabilities = capabilities,
				}
			end,
			-- custom per‐server overrides:
			["lua_ls"] = function()
				require("lsp.lua").setup({ capabilities = capabilities })
			end,
			["clangd"] = function()
				require("lsp.clang").setup({ capabilities = capabilities })
			end,
		})

		-- cmp/snippet setup (no changes needed for 0.12)
		local select_opts = { behavior = cmp.SelectBehavior.Select }
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
				["<C-n>"] = cmp.mapping.select_next_item(select_opts),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			virtual_text = {
				spacing = 1,
			},
			float = {
				focusable = false,
				style     = "minimal",
				border    = "rounded",
				source    = "always",
				header    = "",
				prefix    = "",
			},
		})
	end,
}
