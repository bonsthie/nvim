# C Formatter Configuration Guide

This guide explains how to enable the **C Formatter** plugin for Neovim.

---

## **1. Enabling the Plugin**

You can enable the plugin by creating a configuration file in the `lua/custom/` folder. 

### **Steps to Enable**

1. Navigate to `lua/custom/`.
2. Create a file named `42formatter.lua`.
3. Set the necessary options to enable the plugin.

### **Example Configuration**

```lua
local M = {}

function M.modify_opts(opts)
    opts.enable = true -- Enable the plugin
    return opts
end

return M
```

---

