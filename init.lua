-- ************************************************************************** --
--                                                                            --
--                                                        :::      ::::::::   --
--   init.lua                                           :+:      :+:    :+:   --
--                                                    +:+ +:+         +:+     --
--   By: babonnet <babonnet@42angouleme.fr>         +#+  +:+       +#+        --
--                                                +#+#+#+#+#+   +#+           --
--   Created: 2024/04/16 16:29:45 by babonnet          #+#    #+#             --
--   Updated: 2025/08/15 15:39:07 by bonsthie         ###   ########.fr       --
--                                                                            --
-- ************************************************************************** --

-- Get version table: {major, minor, patch}
local version = vim.version()

if version.major == 0 and version.minor < 9 then
  vim.notify(
    string.format(
      "⚠️ Your Neovim version is %d.%d.%d. This config requires at least 0.9.0.",
      version.major,
      version.minor,
      version.patch
    ),
    vim.log.levels.WARN
  )
  return  -- Stop config loading gracefully
else
	require('barnabait')
end

