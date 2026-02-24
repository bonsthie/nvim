return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	config = function()
		require("neodev").setup({
			library = { plugins = true, types = true },
		})
		require("fidget").setup({})
		require("mason").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()


		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup({
			ensure_installed = { "lua_ls", "clangd" },
		})

		require("lsp.lua").setup(capabilities)
		require("lsp.clang").setup(capabilities)


		local cmp = require('cmp')
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		require('luasnip.loaders.from_vscode').lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer' },
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
				source    = true,
				header    = "",
				prefix    = "",
			},
		})
	end,
}
