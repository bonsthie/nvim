return ({
	"stevearc/oil.nvim",

	opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        keymaps = {
          ['-'] = { "<CMD>Oil<CR>", desc = "Open parent directory" },
          ['<C-h>'] = false, -- unbind C-hjkl for compatibility with tmux vim mode
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false
        },
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      })

      vim.api.nvim_create_user_command("Ex", "Oil", {})
    end
})
