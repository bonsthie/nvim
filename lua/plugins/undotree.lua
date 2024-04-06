return {
	"mbbill/undotree",
	event = "InsertEnter",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end
}
