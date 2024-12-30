local M = {}

--- Get all `.lua` file names in a directory (without extension)
local function get_lua_files(dir)
    local abs_dir = vim.fn.stdpath("config") .. dir
    local modules = {}

    -- Attempt to read directory
    local ok, files = pcall(vim.fn.readdir, abs_dir)
    if not ok or not files then
        vim.notify("Directory not found: " .. abs_dir, vim.log.levels.WARN)
        return modules
    end

    for _, file in ipairs(files) do
        if file:match("%.lua$") then
            local module_name = file:gsub("%.lua$", "") -- Remove `.lua`
            table.insert(modules, module_name)
        end
    end

    return modules
end

--- Safely load a plugin and apply optional overrides
local function load_plugin(prefix, plugin_name, opts_override_fn)
    local ok, plugin = pcall(require, prefix .. plugin_name)
    if not ok or type(plugin) ~= "table" then
        return
    end

    local opts = plugin.opts or {}
    -- Apply partial override function (if provided)
    if opts_override_fn and type(opts_override_fn) == "function" then
        opts = opts_override_fn(opts)
    end

    if type(plugin.config) == "function" then
        plugin.config(plugin.name, opts)
    end
end

--- Master function to load plugins with full and partial overrides
function M.load_plugins()
    -- List of base plugins from /lua/plugins
    local base_plugins = get_lua_files("/lua/plugins")
    -- List of full override plugins from /lua/custom/plugins
    local full_overrides = get_lua_files("/lua/custom/plugins")
    -- List of partial overrides from /lua/custom
    local partial_overrides = get_lua_files("/lua/custom")

    -- 1) Load base plugins with potential overrides
    for _, plugin_name in ipairs(base_plugins) do
        if vim.tbl_contains(full_overrides, plugin_name) then
            ----------------------------------------------------------------
            ---  (A) FULL OVERRIDE ---
            ----------------------------------------------------------------
            -- Load full override from /lua/custom/plugins
            load_plugin("custom.plugins.", plugin_name)
        else
            ----------------------------------------------------------------
            ---  (B) PARTIAL OVERRIDE ---
            ----------------------------------------------------------------
            -- Check for partial override in /lua/custom/<plugin_name>.lua
            local override_fn = nil
            if vim.tbl_contains(partial_overrides, plugin_name) then
                local ok, partial_mod = pcall(require, "custom." .. plugin_name)
                if ok and type(partial_mod) == "table" and partial_mod.modify_opts then
                    override_fn = partial_mod.modify_opts
                end
            end

            -- Load base plugin with optional partial override
            load_plugin("plugins.", plugin_name, override_fn)
        end
    end

    -- 2) Load additional custom plugins that do not match any base plugin
    for _, plugin_name in ipairs(full_overrides) do
        if not vim.tbl_contains(base_plugins, plugin_name) then
            -- Load custom plugin from /lua/custom/plugins
            load_plugin("custom.plugins.", plugin_name)
        end
    end
end

return M
