return {
	"cacharle/c_formatter_42.vim",
	run = "CFormatter42",
	opts = {
		enable = false, -- Default: plugin is disabled
	},
	config = function(_, opts)
	end,
	cond = function()
		local ok, custom = pcall(require, "custom.42formatter")
		local default_opts = {
			enable = false,
		}
		if ok and custom.modify_opts then
			default_opts = custom.modify_opts(default_opts)
		end

		return default_opts.enable
	end
}
