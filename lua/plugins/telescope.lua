return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})


		vim.keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.expand("%:p:h"), -- directory of current file
			})
		end, { desc = "Find files in current file's directory" })


		-- Find files from parent dir of current file
		vim.keymap.set("n", "<leader>fp", function()
			require("telescope.builtin").find_files({
				cwd = vim.fn.expand("%:p:h:h"), -- go up one level
			})
		end, { desc = "Find files in parent of current file's directory" })
	end
}
