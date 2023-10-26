-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   42header.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: bbonnet <bbonnet@42angouleme.fr>           +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/09/16 00:38:46 by bbonnet           #+#    #+#             --
--   Updated: 2023/09/16 00:39:08 by bbonnet          ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

local header = require("42header")
header.setup({
  length = 80, -- headers of different sizes are incompatible with each other
  margin = 5,
  default_map = true, -- default Mapping <F1> in normal mode
  auto_update = true, -- update header when saving
  user = "bbonnet", -- your user
  mail = "bbonnet@42angouleme.fr", -- your mail
  -- asciiart = { "......", "......",} -- headers with different ascii arts are incompatible with each other
})

vim.api.nvim_set_keymap('n', '11', ':Stdheader<CR>', { noremap = true, silent = true })

