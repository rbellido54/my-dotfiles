-- lazy-bootstrap.lua
-- Bootstrap script for automatic lazy.nvim installation
-- This ensures lazy.nvim is installed and available before we try to use it

local M = {}

-- Function to bootstrap lazy.nvim installation
function M.bootstrap()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  
  -- Check if lazy.nvim is already installed
  if not vim.loop.fs_stat(lazypath) then
    vim.notify("Installing lazy.nvim plugin manager...", vim.log.levels.INFO)
    
    -- Clone lazy.nvim repository
    local success = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
    
    -- Check if clone was successful
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to clone lazy.nvim: " .. success, vim.log.levels.ERROR)
      return false
    end
    
    vim.notify("lazy.nvim installed successfully!", vim.log.levels.INFO)
  end
  
  -- Add lazy.nvim to runtime path
  vim.opt.rtp:prepend(lazypath)
  
  return true
end

-- Function to check if lazy.nvim is available
function M.is_available()
  local ok = pcall(require, "lazy")
  return ok
end

-- Function to get the installation path
function M.get_path()
  return vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
end

-- Function to install lazy.nvim and verify it's working
function M.setup()
  local success = M.bootstrap()
  
  if not success then
    vim.notify("Failed to bootstrap lazy.nvim", vim.log.levels.ERROR)
    return false
  end
  
  -- Try to require lazy.nvim to verify it's working
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    vim.notify("lazy.nvim installed but cannot be loaded: " .. tostring(lazy), vim.log.levels.ERROR)
    return false
  end
  
  vim.notify("lazy.nvim is ready!", vim.log.levels.DEBUG)
  return true
end

return M