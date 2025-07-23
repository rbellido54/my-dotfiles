-- config/keymaps/core.lua
-- Essential Vim keymaps that should always be available
-- These are fundamental editor bindings independent of plugins

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  
  -- Define core keymaps with descriptions
  -- Only the most essential keymaps that should always be available
  local core_mappings = {
    -- Essential escape and save mappings
    { "jj", "<Esc>", desc = "Quick escape to normal mode", mode = "i" },
    { "<C-c>", "<Esc>", desc = "Alternative escape", mode = { "n", "i" } },
    { "<C-s>", "<cmd>w<CR>", desc = "Save file", mode = "n" },
    { "<C-Q>", "<cmd>wq!<CR>", desc = "Save and quit", mode = "n" },
    
    -- Quick save all and quit operations
    { "<Leader>w", "<cmd>wa<CR>", desc = "Save all buffers", mode = "n" },
    { "<Leader>Q", "<cmd>qa!<CR>", desc = "Force quit all", mode = "n" },
    
    -- Essential help and information
    { "<F1>", "<cmd>help<CR>", desc = "Open help", mode = "n" },
    
    -- Essential undo/redo (Vim defaults but documented)
    { "u", "u", desc = "Undo", mode = "n" },
    { "<C-r>", "<C-r>", desc = "Redo", mode = "n" },
    
    -- Essential search (Vim defaults but documented for which-key)
    { "/", "/", desc = "Search forward", mode = "n" },
    { "?", "?", desc = "Search backward", mode = "n" },
    
    -- Essential repeat command
    { ".", ".", desc = "Repeat last command", mode = "n" },
    
    -- Enter insert mode variants (documented for completeness)
    { "i", "i", desc = "Insert before cursor", mode = "n" },
    { "I", "I", desc = "Insert at line beginning", mode = "n" },
    { "a", "a", desc = "Insert after cursor", mode = "n" },
    { "A", "A", desc = "Insert at line end", mode = "n" },
    { "o", "o", desc = "Insert line below", mode = "n" },
    { "O", "O", desc = "Insert line above", mode = "n" },
    
    -- Essential visual mode (documented for which-key)
    { "v", "v", desc = "Visual mode", mode = "n" },
    { "V", "V", desc = "Visual line mode", mode = "n" },
    { "<C-v>", "<C-v>", desc = "Visual block mode", mode = "n" },
    
    -- Essential copy/paste (documented for which-key)
    { "y", "y", desc = "Yank", mode = { "n", "v" } },
    { "p", "p", desc = "Paste after", mode = "n" },
    { "P", "P", desc = "Paste before", mode = "n" },
    
    -- Essential delete operations (documented for which-key)
    { "x", "x", desc = "Delete character", mode = "n" },
    { "X", "X", desc = "Delete character before", mode = "n" },
    { "dd", "dd", desc = "Delete line", mode = "n" },
    
    -- Essential movement (documented for which-key)
    { "h", "h", desc = "Move left", mode = "n" },
    { "j", "j", desc = "Move down", mode = "n" },
    { "k", "k", desc = "Move up", mode = "n" },
    { "l", "l", desc = "Move right", mode = "n" },
    { "w", "w", desc = "Next word", mode = "n" },
    { "b", "b", desc = "Previous word", mode = "n" },
    { "e", "e", desc = "End of word", mode = "n" },
    { "0", "0", desc = "Start of line", mode = "n" },
    { "^", "^", desc = "First non-blank", mode = "n" },
    { "$", "$", desc = "End of line", mode = "n" },
    { "gg", "gg", desc = "First line", mode = "n" },
    { "G", "G", desc = "Last line", mode = "n" },
  }
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(core_mappings) do
    if mapping[1] and mapping[2] then
      local modes = mapping.mode or "n"
      local opts = {
        desc = mapping.desc,
        noremap = mapping.noremap ~= false,
        silent = mapping.silent ~= false,
        expr = mapping.expr,
      }
      vim.keymap.set(modes, mapping[1], mapping[2], opts)
    end
  end
  
  -- Also register with which-key for better help display
  if wk_helper then
    wk_helper.add_keymaps(core_mappings)
  end
  
  -- Additional Vim options that complement these keymaps
  vim.opt.timeoutlen = 300 -- Faster which-key trigger
  vim.opt.updatetime = 250 -- Faster CursorHold events
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  essential = { "jj", "<C-c>", "<C-s>", "<C-Q>" },
  save_quit = { "<Leader>w", "<Leader>Q" },
  help = { "<F1>" },
  undo_redo = { "u", "<C-r>" },
  search = { "/", "?" },
  repeat_cmd = { "." },
  insert_modes = { "i", "I", "a", "A", "o", "O" },
  visual_modes = { "v", "V", "<C-v>" },
  copy_paste = { "y", "p", "P" },
  delete_ops = { "x", "X", "dd" },
  movement = { "h", "j", "k", "l", "w", "b", "e", "0", "^", "$", "gg", "G" },
}

return M