return	{
	"bonsthie/fastclass.nvim",
	config = function()
		require("fastclass").setup({
			header = false,
			clangformat = true,
			header_extension = ".h",
			pragma_once_header = true,
		})
	end
}
