local M = {}

function M.get_dir()
	local oil_dir = require('oil').get_current_dir()
	if not oil_dir then
		return vim.fn.expand("%:p:h")
	end
	return oil_dir
end

return M

