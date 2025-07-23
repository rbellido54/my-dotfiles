-- config/keymaps/init.lua
-- Modern modular keymap management system
-- Entry point for organized, maintainable keymaps with which-key integration

local M = {}

-- Configuration for keymap loading
local keymap_config = {
  -- Enable/disable debug output for keymap loading
  debug = false,
  
  -- Fallback to old keymaps if new system fails
  fallback_enabled = true,
  
  -- Conditional loading based on plugin availability
  check_plugins = true,
}

-- Utility function for debug logging
local function debug_log(message)
  if keymap_config.debug then
    vim.notify("[Keymaps] " .. message, vim.log.levels.DEBUG)
  end
end

-- Check if a plugin is available and loaded
local function is_plugin_available(plugin_name)
  if not keymap_config.check_plugins then
    return true
  end
  
  local ok, _ = pcall(require, plugin_name)
  return ok
end

-- Safe require function with error handling
local function safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    debug_log("Failed to load module: " .. module_name .. " - " .. tostring(result))
    return false, result
  end
  return true, result
end

-- Core keymap modules (always loaded)
local core_modules = {
  "config.keymaps.core",      -- Essential vim keymaps
  "config.keymaps.editor",    -- Text editing and manipulation
  "config.keymaps.navigation", -- Window and buffer navigation
  "config.keymaps.themes",    -- Theme switching and customization
}

-- Plugin-dependent keymap modules
local plugin_modules = {
  {
    module = "config.keymaps.git",
    plugins = { "vim-fugitive", "vim-signify", "lazygit.nvim" },
    description = "Git integration keymaps"
  },
  {
    module = "config.keymaps.fzf",
    plugins = { "fzf.vim" },
    description = "FZF fuzzy finder keymaps"
  },
  {
    module = "config.keymaps.lsp",
    plugins = { "nvim-lspconfig" },
    description = "LSP and development tool keymaps"
  },
  {
    module = "config.keymaps.ai",
    plugins = { "copilot.vim", "CopilotChat.nvim" },
    description = "AI and Copilot keymaps"
  },
  {
    module = "config.keymaps.terminal",
    plugins = { "vim-floaterm" },
    description = "Terminal management keymaps"
  },
}

-- Load core keymap modules
local function load_core_keymaps()
  debug_log("Loading core keymap modules...")
  local loaded_count = 0
  
  for _, module_name in ipairs(core_modules) do
    local ok, module = safe_require(module_name)
    if ok then
      loaded_count = loaded_count + 1
      debug_log("✓ Loaded core module: " .. module_name)
      
      -- If module has a setup function, call it
      if type(module) == "table" and type(module.setup) == "function" then
        module.setup()
      end
    else
      vim.notify("Failed to load core keymap module: " .. module_name, vim.log.levels.WARN)
    end
  end
  
  debug_log(string.format("Loaded %d/%d core keymap modules", loaded_count, #core_modules))
  return loaded_count
end

-- Load plugin-dependent keymap modules
local function load_plugin_keymaps()
  debug_log("Loading plugin-dependent keymap modules...")
  local loaded_count = 0
  
  for _, config in ipairs(plugin_modules) do
    -- Check if any of the required plugins are available
    local plugin_available = false
    for _, plugin_name in ipairs(config.plugins) do
      if is_plugin_available(plugin_name) then
        plugin_available = true
        break
      end
    end
    
    if plugin_available then
      local ok, module = safe_require(config.module)
      if ok then
        loaded_count = loaded_count + 1
        debug_log("✓ Loaded plugin module: " .. config.module .. " (" .. config.description .. ")")
        
        -- If module has a setup function, call it
        if type(module) == "table" and type(module.setup) == "function" then
          module.setup()
        end
      else
        debug_log("Failed to load plugin module: " .. config.module)
      end
    else
      debug_log("Skipping " .. config.module .. " - required plugins not available")
    end
  end
  
  debug_log(string.format("Loaded %d/%d plugin keymap modules", loaded_count, #plugin_modules))
  return loaded_count
end

-- Load which-key integration
local function setup_which_key()
  if not is_plugin_available("which-key") then
    debug_log("which-key not available, skipping integration")
    return false
  end
  
  local ok, wk_module = safe_require("config.keymaps.which-key-integration")
  if ok and type(wk_module.setup) == "function" then
    wk_module.setup()
    debug_log("✓ which-key integration configured")
    return true
  else
    debug_log("Failed to setup which-key integration")
    return false
  end
end

-- Fallback to legacy keymap system
local function load_legacy_keymaps()
  if not keymap_config.fallback_enabled then
    return false
  end
  
  debug_log("Loading legacy keymap fallback...")
  
  -- Load the old keymaps.lua file as fallback
  local ok, _ = safe_require("config.keymaps-legacy")
  if ok then
    debug_log("✓ Legacy keymaps loaded as fallback")
    return true
  else
    -- If legacy file doesn't exist, try to load from the original location
    vim.notify("Keymap fallback: Loading original keymaps", vim.log.levels.WARN)
    return false
  end
end

-- Main setup function
function M.setup()
  debug_log("Initializing modern keymap system...")
  
  -- Track loading statistics
  local stats = {
    core_modules = 0,
    plugin_modules = 0,
    which_key_loaded = false,
    fallback_used = false,
  }
  
  -- Load core keymaps
  stats.core_modules = load_core_keymaps()
  
  -- Load plugin-dependent keymaps
  stats.plugin_modules = load_plugin_keymaps()
  
  -- Setup which-key integration
  stats.which_key_loaded = setup_which_key()
  
  -- If no modules loaded successfully, try fallback
  if stats.core_modules == 0 and stats.plugin_modules == 0 then
    stats.fallback_used = load_legacy_keymaps()
    if stats.fallback_used then
      vim.notify("Keymaps loaded using legacy fallback system", vim.log.levels.WARN)
    else
      vim.notify("Failed to load any keymap modules!", vim.log.levels.ERROR)
    end
  else
    local total_loaded = stats.core_modules + stats.plugin_modules
    local message = string.format("Modern keymaps loaded: %d modules", total_loaded)
    if stats.which_key_loaded then
      message = message .. " (with which-key integration)"
    end
    vim.notify(message, vim.log.levels.INFO)
  end
  
  -- Store stats for external access
  M.stats = stats
  
  debug_log("Keymap system initialization complete")
end

-- Get loading statistics
function M.get_stats()
  return M.stats or {
    core_modules = 0,
    plugin_modules = 0,
    which_key_loaded = false,
    fallback_used = false,
  }
end

-- Enable/disable debug mode
function M.set_debug(enabled)
  keymap_config.debug = enabled
  debug_log("Debug mode " .. (enabled and "enabled" or "disabled"))
end

-- Reload all keymaps (useful for development)
function M.reload()
  debug_log("Reloading keymap system...")
  
  -- Clear any cached modules
  for _, module_name in ipairs(core_modules) do
    package.loaded[module_name] = nil
  end
  
  for _, config in ipairs(plugin_modules) do
    package.loaded[config.module] = nil
  end
  
  package.loaded["config.keymaps.which-key-integration"] = nil
  
  -- Reload the system
  M.setup()
end

-- Export configuration for external access
M.config = keymap_config
M.core_modules = core_modules
M.plugin_modules = plugin_modules

return M