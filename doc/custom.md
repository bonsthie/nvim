# Custom Configuration Guide for Neovim

This guide explains how to customize your Neovim configuration by overriding settings or adding new plugins. By organizing your custom configurations in the `nvim/lua/custom/` directory, you can maintain a clean and modular setup.

---

## **1. Overriding Plugin Settings**

To override the settings of an existing plugin from the `nvim/lua/plugins/` folder, create a corresponding file in the `nvim/lua/custom/` directory:

### **Steps:**
1. Identify the plugin you want to customize.
2. Create a file named `<plugin_name>.lua` in `nvim/lua/custom/`.
3. Inside this file, define a function called `modify_opts` to adjust the plugin's options.

### **Example**

**Base Plugin:** `nvim/lua/plugins/color.lua`
```lua
return {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
        theme = "rose-pine", -- Default theme
    },
    config = function(_, opts)
        vim.cmd("colorscheme " .. opts.theme)
    end,
}
```

**Override Settings:** `nvim/lua/custom/color.lua`
```lua
local M = {}

function M.modify_opts(opts)
    opts.theme = "rose-pine-dawn" -- Use a different theme
    return opts
end

return M
```
---

## **2. Adding New Plugins or Fully Overriding Existing Plugins**

To add a new plugin or completely replace an existing one, create a file in the `nvim/lua/custom/plugins/` directory.

### **Steps:**
1. For new plugins, create a descriptive file name in `nvim/lua/custom/plugins/`.
2. For overriding an existing plugin, use the same name as the plugin file in `nvim/lua/plugins/`.
3. Define the full plugin configuration in this file.

### **Example**

**New Plugin:** `nvim/lua/custom/plugins/example.lua`
```lua
return {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    opts = {
        ensure_installed = { "lua", "python" },
        highlight = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
```

**Override Existing Plugin:** `nvim/lua/custom/plugins/color.lua`
```lua
return {
    "morhetz/gruvbox",
    name = "gruvbox",
    opts = {
        theme = "gruvbox",
    },
    config = function(_, opts)
        vim.cmd("colorscheme " .. opts.theme)
    end,
}
```

---

## **3. Directory Summary**

### **Overriding Plugin Settings:**
- Place files in `nvim/lua/custom/<plugin_name>.lua`.

### **Adding or Overriding Plugins:**
- Place files in `nvim/lua/custom/plugins/<plugin_name>.lua`.

---

## **Examples**

1. **Override Plugin Settings:**
   - File: `nvim/lua/custom/color.lua`
   - Purpose: Change the theme of the `rose-pine` plugin.

2. **Add or Override Plugin:**
   - File: `nvim/lua/custom/plugins/example.lua`
   - Purpose: Add a new plugin (`nvim-treesitter`).

   - File: `nvim/lua/custom/plugins/color.lua`
   - Purpose: Replace the `rose-pine` plugin with `gruvbox`.

---

Feel free to create, modify, or replace plugins using these conventions to suit your workflow!

