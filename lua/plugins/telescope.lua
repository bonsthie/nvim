return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		vim.keymap.set('n', '<leader>pd', function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
				cwd = require("barnabait.utils").fs.get_dir()
			})
		end)
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})


		vim.keymap.set("n", "<leader>fd", function()
			require("telescope.builtin").find_files({
				cwd = require("barnabait.utils").fs.get_dir()
			})
		end, { desc = "Find files in current file's directory" })


		-- Find files from parent dir of current file
		vim.keymap.set("n", "<leader>fp", function()
			local path = require("barnabait.utils").fs.get_dir() .. "../"
			require("telescope.builtin").find_files({
				cwd = path
			})
		end, { desc = "Find files in parent of current file's directory" })
	end
}
