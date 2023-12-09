-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   42header.lua                                       :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: babonnet <babonnet@42angouleme.fr>         +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2023/09/16 00:38:46 by bbonnet           #+#    #+#             --
--   Updated: 2023/12/09 21:32:20 by babonnet         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

local header = require("42header")
header.setup({
  length = 80, -- headers of different sizes are incompatible with each other
  margin = 5,
  default_map = true, -- default Mapping <F1> in normal mode
  auto_update = true, -- update header when saving
  user = "babonnet", -- your user
  mail = "babonnet@42angouleme.fr", -- your mail
  -- asciiart = { "......", "......",} -- headers with different ascii arts are incompatible with each other
})

vim.api.nvim_set_keymap('n', '<leader>11', ':Stdheader<CR>', { noremap = true, silent = true })

