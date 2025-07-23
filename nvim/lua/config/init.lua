-- config/init.lua
-- Module loader for Neovim configuration
-- Part of the core configuration migration to Lua

-- Initialize startup profiling
local profiler = require("config.startup-profiler")
profiler.profile_startup()

-- Initialize plugin manager first
require("config.plugin-manager").setup()

-- List of configuration modules to load
local config_modules = {
  "config.options",   -- Vim options and settings
  "config.keymaps",   -- Key mappings
  "config.autocmds",  -- Auto commands
}

-- Function to safely require a module with error handling
local function safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    vim.notify("Failed to load module: " .. module_name .. "\nError: " .. result, vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Load all configuration modules
local function load_config()
  vim.notify("Loading Lua configuration modules...", vim.log.levels.INFO)
  
  local loaded_count = 0
  local total_count = #config_modules
  
  for _, module_name in ipairs(config_modules) do
    if safe_require(module_name) then
      loaded_count = loaded_count + 1
      vim.notify("✓ Loaded: " .. module_name, vim.log.levels.DEBUG)
    end
  end
  
  local message = string.format("Configuration loaded: %d/%d modules", loaded_count, total_count)
  if loaded_count == total_count then
    vim.notify(message, vim.log.levels.INFO)
  else
    vim.notify(message .. " (some modules failed to load)", vim.log.levels.WARN)
  end
end

-- Load configuration on module require
load_config()

-- Return module for potential future use
return {
  load_config = load_config,
  safe_require = safe_require,
}