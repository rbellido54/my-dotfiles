-- plugin-manager.lua
-- Plugin manager with fallback mechanism
-- Tries to use lazy.nvim, falls back to vim-plug if needed

local M = {}

-- Check if lazy.nvim bootstrap was successful
local function try_lazy()
  local bootstrap = require("config.lazy-bootstrap")
  
  -- Try to bootstrap lazy.nvim
  local success = bootstrap.setup()
  if not success then
    vim.notify("Failed to setup lazy.nvim, falling back to vim-plug", vim.log.levels.WARN)
    return false
  end
  
  -- Try to load plugins with lazy.nvim
  local ok = pcall(require, "config.plugins")
  if not ok then
    vim.notify("Failed to load lazy.nvim plugins, falling back to vim-plug", vim.log.levels.WARN)
    return false
  end
  
  vim.notify("Using lazy.nvim plugin manager", vim.log.levels.INFO)
  return true
end

-- Fallback to vim-plug
local function use_vim_plug()
  vim.notify("Using vim-plug plugin manager (fallback)", vim.log.levels.INFO)
  
  -- Source the original vim-plug configuration
  local plug_file = vim.fn.expand("$HOME/.config/nvim/vim-plug/plugins.vim")
  if vim.fn.filereadable(plug_file) == 1 then
    vim.cmd("source " .. plug_file)
    return true
  else
    vim.notify("vim-plug configuration not found: " .. plug_file, vim.log.levels.ERROR)
    return false
  end
end

-- Main setup function
function M.setup()
  -- Try lazy.nvim first
  if try_lazy() then
    M.manager = "lazy"
    return true
  end
  
  -- Fall back to vim-plug
  if use_vim_plug() then
    M.manager = "vim-plug"
    return true
  end
  
  -- Both failed
  vim.notify("Failed to initialize any plugin manager!", vim.log.levels.ERROR)
  M.manager = "none"
  return false
end

-- Get current plugin manager
function M.get_manager()
  return M.manager or "unknown"
end

-- Check if a specific manager is active
function M.is_lazy()
  return M.manager == "lazy"
end

function M.is_vim_plug()
  return M.manager == "vim-plug"
end

return M