return {
  {
    "matze/wastebin.nvim",
    config = function ()
		require("wastebin").setup({
			url = "https://paste.kanel.ovh",
			--	To open it on default internet browser (works with xdg)
			open_cmd = "open",
			--	If on wayland (pkgs : wl-clipboard)
			-- open_cmd = "wl-copy",
		})
	end,
  }
}
