-- config/keymaps/which-key-integration.lua
-- Modern which-key integration for organized keymap display and management

local M = {}

-- Check if which-key is available
local function is_which_key_available()
  local ok, wk = pcall(require, "which-key")
  return ok, wk
end

-- Modern which-key configuration
local function configure_which_key()
  local ok, wk = is_which_key_available()
  if not ok then
    return false
  end
  
  -- Modern which-key v3 configuration
  wk.setup({
    preset = "modern", -- Use modern preset for better appearance
    delay = 200, -- Delay before showing which-key popup (ms)
    
    -- Expand groups automatically when there's only one group
    expand = 1,
    
    -- Show command in the command line while typing
    notify = true,
    
    -- Disable for certain modes to avoid conflicts
    disable = {
      buftypes = {},
      filetypes = {},
    },
    
    -- Filter rules for keys/mappings
    filter = function(mapping)
      -- Hide mappings without description
      return mapping.desc and mapping.desc ~= ""
    end,
    
    -- Specify the keys that trigger the which-key popup
    triggers = {
      { "<auto>", mode = "nxso" }, -- Auto-detect triggers in normal, visual, select, operator-pending modes
    },
    
    -- Icons configuration
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and its label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      -- Mappings for different key types
      mappings = true,
      rules = {
        { pattern = "git", icon = "", color = "orange" },
        { pattern = "file", icon = "", color = "blue" },
        { pattern = "buffer", icon = "", color = "cyan" },
        { pattern = "window", icon = "", color = "purple" },
        { pattern = "terminal", icon = "", color = "green" },
        { pattern = "ai", icon = "🤖", color = "yellow" },
        { pattern = "copilot", icon = "", color = "yellow" },
        { pattern = "lsp", icon = "", color = "blue" },
        { pattern = "debug", icon = "", color = "red" },
        { pattern = "test", icon = "", color = "green" },
        { pattern = "search", icon = "", color = "cyan" },
        { pattern = "format", icon = "", color = "purple" },
      },
    },
    
    -- Window configuration
    win = {
      border = "rounded",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = true,
      title_pos = "center",
      zindex = 1000,
      -- Window options
      wo = {
        winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    
    -- Layout configuration
    layout = {
      width = { min = 20 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    
    -- Plugin integrations
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- Built-in presets for common key patterns
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
  })
  
  return true
end

-- Register common group names for consistent naming
local function register_groups()
  local ok, wk = is_which_key_available()
  if not ok then
    return false
  end
  
  -- Define group names for better organization (based on modular keymap system)
  wk.add({
    -- Main leader key groups (aligned with modular system)
    { "<leader>a", group = "AI & Copilot", icon = "🤖" },
    { "<leader>b", group = "Buffers", icon = "" },
    { "<leader>c", group = "Commands & Code", icon = "" },
    { "<leader>d", group = "Debug & Delete", icon = "" },
    { "<leader>f", group = "Find & Files", icon = "" },
    { "<leader>g", group = "Git", icon = "" },
    { "<leader>h", group = "Help & Hints", icon = "" },
    { "<leader>l", group = "LSP & Language", icon = "" },
    { "<leader>m", group = "Marks & Misc", icon = "" },
    { "<leader>p", group = "Project & Path", icon = "" },
    { "<leader>q", group = "Quit & Quickfix", icon = "" },
    { "<leader>r", group = "Replace & Refactor", icon = "" },
    { "<leader>s", group = "Search & Substitute", icon = "" },
    { "<leader>t", group = "Terminal & Tabs", icon = "" },
    { "<leader>u", group = "UI & Utils", icon = "" },
    { "<leader>w", group = "Windows & Workspace", icon = "" },
    { "<leader>x", group = "Execute & Diagnostics", icon = "" },
    { "<leader>y", group = "Yank & Copy", icon = "" },
    { "<leader>z", group = "Folding & Spell", icon = "" },
    
    -- AI & Copilot subgroups
    { "<leader>aa", group = "Chat Operations", icon = "💬" },
    { "<leader>ac", group = "Code Analysis", icon = "" },
    { "<leader>as", group = "Settings & Status", icon = "⚙️" },
    
    -- Git subgroups
    { "<leader>gj", group = "Hunk Navigation", icon = "🔄" },
    { "<leader>gl", group = "Logs & History", icon = "" },
    { "<leader>gs", group = "Status & Staging", icon = "" },
    { "<leader>gb", group = "Branches & Blame", icon = "" },
    
    -- LSP subgroups
    { "<leader>ld", group = "Diagnostics", icon = "" },
    { "<leader>lf", group = "Formatting", icon = "" },
    { "<leader>ls", group = "Server Control", icon = "⚙️" },
    { "<leader>lw", group = "Workspace", icon = "" },
    { "<leader>lc", group = "Code Actions", icon = "" },
    
    -- Terminal subgroups
    { "<leader>tt", group = "Terminal Toggle", icon = "" },
    { "<leader>tn", group = "New Terminal", icon = "+" },
    { "<leader>tg", group = "Git Tools", icon = "" },
    { "<leader>tr", group = "File Managers", icon = "" },
    
    -- Buffer navigation subgroups
    { "<leader>bl", group = "Buffer Lines", icon = "" },
    { "<leader>bd", group = "Buffer Delete", icon = "" },
    
    -- Window management subgroups
    { "<leader>wh", group = "Horizontal Split", icon = "⬌" },
    { "<leader>wv", group = "Vertical Split", icon = "⬍" },
    { "<leader>wc", group = "Close Window", icon = "✕" },
    
    -- Special key groups
    { "g", group = "Go to", icon = "➜" },
    { "z", group = "Folds & Spelling", icon = "" },
    { "]", group = "Next", icon = "→" },
    { "[", group = "Previous", icon = "←" },
    { "<C-w>", group = "Windows", icon = "" },
    
    -- Function key groups
    { "<F1>", desc = "Help", icon = "❓" },
    { "<F2>", desc = "Terminal Next", icon = "" },
    { "<F3>", desc = "Terminal Prev", icon = "" },
    { "<F8>", desc = "Terminal Kill", icon = "✕" },
    { "<F10>", desc = "Terminal New", icon = "+" },
    { "<F12>", desc = "Terminal Toggle", icon = "" },
  })
  
  return true
end

-- Register commonly used operators for better help
local function register_operators()
  local ok, wk = is_which_key_available()
  if not ok then
    return false
  end
  
  -- Add descriptions for common operators
  wk.add({
    { "gc", desc = "Comment toggle", mode = { "n", "v" } },
    { "gb", desc = "Block comment toggle", mode = { "n", "v" } },
    { "ys", desc = "Surround", mode = "n" },
    { "ds", desc = "Delete surround", mode = "n" },
    { "cs", desc = "Change surround", mode = "n" },
  })
  
  return true
end

-- Setup function called by the main keymap system
function M.setup()
  -- Configure which-key with modern settings
  local configured = configure_which_key()
  if not configured then
    vim.notify("which-key not available - skipping integration", vim.log.levels.WARN)
    return false
  end
  
  -- Register group names
  register_groups()
  
  -- Register common operators
  register_operators()
  
  -- Create commands for keymap management
  vim.api.nvim_create_user_command("WhichKey", function(opts)
    local ok, wk = is_which_key_available()
    if ok then
      if opts.args and opts.args ~= "" then
        wk.show(opts.args)
      else
        wk.show()
      end
    end
  end, { 
    nargs = "?", 
    desc = "Show which-key popup for specified prefix or all mappings" 
  })
  
  vim.api.nvim_create_user_command("WhichKeyReload", function()
    package.loaded["which-key"] = nil
    M.setup()
    vim.notify("which-key configuration reloaded", vim.log.levels.INFO)
  end, { desc = "Reload which-key configuration" })
  
  return true
end

-- Helper function to add keymaps with which-key integration
function M.add_keymaps(mappings)
  local ok, wk = is_which_key_available()
  if ok then
    wk.add(mappings)
    return true
  end
  
  -- Fallback: register keymaps manually without which-key
  for _, mapping in ipairs(mappings) do
    if mapping[1] and mapping[2] then
      local modes = mapping.mode or "n"
      local opts = {
        desc = mapping.desc,
        noremap = mapping.noremap ~= false,
        silent = mapping.silent ~= false,
      }
      vim.keymap.set(modes, mapping[1], mapping[2], opts)
    end
  end
  
  return false
end

-- Get which-key status
function M.get_status()
  local ok, wk = is_which_key_available()
  return {
    available = ok,
    version = ok and (wk.version or "unknown") or nil,
    configured = ok and true or false,
  }
end

return M