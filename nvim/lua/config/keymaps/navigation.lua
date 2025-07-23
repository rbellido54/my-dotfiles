-- config/keymaps/navigation.lua
-- Window, buffer, and general navigation keymaps
-- These keymaps improve movement and navigation efficiency

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
  
  -- Define navigation keymaps with descriptions
  local navigation_mappings = {
    -- Better window navigation
    { "<C-h>", "<C-w>h", desc = "Move to left window", mode = "n" },
    { "<C-j>", "<C-w>j", desc = "Move to bottom window", mode = "n" },
    { "<C-k>", "<C-w>k", desc = "Move to top window", mode = "n" },
    { "<C-l>", "<C-w>l", desc = "Move to right window", mode = "n" },
    
    -- Window resizing with Alt+hjkl
    { "<M-h>", "<cmd>vertical resize -2<CR>", desc = "Decrease window width", mode = "n" },
    { "<M-j>", "<cmd>resize -2<CR>", desc = "Decrease window height", mode = "n" },
    { "<M-k>", "<cmd>resize +2<CR>", desc = "Increase window height", mode = "n" },
    { "<M-l>", "<cmd>vertical resize +2<CR>", desc = "Increase window width", mode = "n" },
    
    -- Better tab navigation
    { "<TAB>", "<cmd>bnext<CR>", desc = "Next buffer", mode = "n" },
    { "<S-TAB>", "<cmd>bprevious<CR>", desc = "Previous buffer", mode = "n" },
    
    -- Window management
    { "<Leader>wh", "<C-w>s", desc = "Split window horizontally", mode = "n" },
    { "<Leader>wv", "<C-w>v", desc = "Split window vertically", mode = "n" },
    { "<Leader>wc", "<C-w>c", desc = "Close current window", mode = "n" },
    { "<Leader>wo", "<C-w>o", desc = "Close other windows", mode = "n" },
    { "<Leader>w=", "<C-w>=", desc = "Equalize window sizes", mode = "n" },
    
    -- Window rotation
    { "<Leader>wr", "<C-w>r", desc = "Rotate windows", mode = "n" },
    { "<Leader>wR", "<C-w>R", desc = "Rotate windows reverse", mode = "n" },
    
    -- Window movement
    { "<Leader>wH", "<C-w>H", desc = "Move window to far left", mode = "n" },
    { "<Leader>wJ", "<C-w>J", desc = "Move window to bottom", mode = "n" },
    { "<Leader>wK", "<C-w>K", desc = "Move window to top", mode = "n" },
    { "<Leader>wL", "<C-w>L", desc = "Move window to far right", mode = "n" },
    
    -- Buffer management
    { "<Leader>bd", "<cmd>bdelete<CR>", desc = "Delete buffer", mode = "n" },
    { "<Leader>bD", "<cmd>bdelete!<CR>", desc = "Force delete buffer", mode = "n" },
    { "<Leader>bn", "<cmd>bnext<CR>", desc = "Next buffer", mode = "n" },
    { "<Leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer", mode = "n" },
    { "<Leader>bf", "<cmd>bfirst<CR>", desc = "First buffer", mode = "n" },
    { "<Leader>bl", "<cmd>blast<CR>", desc = "Last buffer", mode = "n" },
    { "<Leader>ba", "<cmd>ball<CR>", desc = "Open all buffers in windows", mode = "n" },
    
    -- Buffer navigation by number
    { "<Leader>1", "<cmd>buffer 1<CR>", desc = "Go to buffer 1", mode = "n" },
    { "<Leader>2", "<cmd>buffer 2<CR>", desc = "Go to buffer 2", mode = "n" },
    { "<Leader>3", "<cmd>buffer 3<CR>", desc = "Go to buffer 3", mode = "n" },
    { "<Leader>4", "<cmd>buffer 4<CR>", desc = "Go to buffer 4", mode = "n" },
    { "<Leader>5", "<cmd>buffer 5<CR>", desc = "Go to buffer 5", mode = "n" },
    { "<Leader>6", "<cmd>buffer 6<CR>", desc = "Go to buffer 6", mode = "n" },
    { "<Leader>7", "<cmd>buffer 7<CR>", desc = "Go to buffer 7", mode = "n" },
    { "<Leader>8", "<cmd>buffer 8<CR>", desc = "Go to buffer 8", mode = "n" },
    { "<Leader>9", "<cmd>buffer 9<CR>", desc = "Go to buffer 9", mode = "n" },
    
    -- Tab management
    { "<Leader>tn", "<cmd>tabnew<CR>", desc = "New tab", mode = "n" },
    { "<Leader>tc", "<cmd>tabclose<CR>", desc = "Close tab", mode = "n" },
    { "<Leader>to", "<cmd>tabonly<CR>", desc = "Close other tabs", mode = "n" },
    { "<Leader>th", "<cmd>tabprevious<CR>", desc = "Previous tab", mode = "n" },
    { "<Leader>tl", "<cmd>tabnext<CR>", desc = "Next tab", mode = "n" },
    { "<Leader>tf", "<cmd>tabfirst<CR>", desc = "First tab", mode = "n" },
    { "<Leader>tL", "<cmd>tablast<CR>", desc = "Last tab", mode = "n" },
    { "<Leader>tm", "<cmd>tabmove<CR>", desc = "Move tab", mode = "n" },
    
    -- Quick navigation
    { "<Leader>;", ":", desc = "Enter command mode", mode = "n" },
    { "gj", "j", desc = "Move down (display line)", mode = "n" },
    { "gk", "k", desc = "Move up (display line)", mode = "n" },
    { "j", "gj", desc = "Move down (logical line)", mode = "n" },
    { "k", "gk", desc = "Move up (logical line)", mode = "n" },
    
    -- Jump list navigation
    { "<C-o>", "<C-o>", desc = "Jump to older position", mode = "n" },
    { "<C-i>", "<C-i>", desc = "Jump to newer position", mode = "n" },
    
    -- Location list navigation
    { "<Leader>ll", "<cmd>lopen<CR>", desc = "Open location list", mode = "n" },
    { "<Leader>lc", "<cmd>lclose<CR>", desc = "Close location list", mode = "n" },
    { "<Leader>ln", "<cmd>lnext<CR>", desc = "Next location", mode = "n" },
    { "<Leader>lp", "<cmd>lprevious<CR>", desc = "Previous location", mode = "n" },
    
    -- Quickfix navigation
    { "<Leader>qo", "<cmd>copen<CR>", desc = "Open quickfix", mode = "n" },
    { "<Leader>qc", "<cmd>cclose<CR>", desc = "Close quickfix", mode = "n" },
    { "<Leader>qn", "<cmd>cnext<CR>", desc = "Next quickfix", mode = "n" },
    { "<Leader>qp", "<cmd>cprevious<CR>", desc = "Previous quickfix", mode = "n" },
    { "<Leader>qf", "<cmd>cfirst<CR>", desc = "First quickfix", mode = "n" },
    { "<Leader>ql", "<cmd>clast<CR>", desc = "Last quickfix", mode = "n" },
    
    -- File navigation
    { "<Leader>cd", "<cmd>cd %:p:h<CR><cmd>pwd<CR>", desc = "Change to file directory", mode = "n" },
    { "<Leader>lcd", "<cmd>lcd %:p:h<CR><cmd>pwd<CR>", desc = "Change local directory", mode = "n" },
    
    -- Fold navigation
    { "zj", "zj", desc = "Next fold", mode = "n" },
    { "zk", "zk", desc = "Previous fold", mode = "n" },
    { "[z", "[z", desc = "Start of current fold", mode = "n" },
    { "]z", "]z", desc = "End of current fold", mode = "n" },
    
    -- Search result navigation (enhanced)
    { "*", "*N", desc = "Search word under cursor (stay)", mode = "n" },
    { "#", "#N", desc = "Search word backward (stay)", mode = "n" },
    
    -- Paragraph navigation
    { "{", "{", desc = "Previous paragraph", mode = "n" },
    { "}", "}", desc = "Next paragraph", mode = "n" },
    
    -- Screen positioning
    { "zt", "zt", desc = "Current line to top", mode = "n" },
    { "zz", "zz", desc = "Current line to center", mode = "n" },
    { "zb", "zb", desc = "Current line to bottom", mode = "n" },
    
    -- Page navigation
    { "<PageUp>", "<C-b>", desc = "Page up", mode = "n" },
    { "<PageDown>", "<C-f>", desc = "Page down", mode = "n" },
    { "<Home>", "gg", desc = "Go to top", mode = "n" },
    { "<End>", "G", desc = "Go to bottom", mode = "n" },
  }
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(navigation_mappings) do
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
    wk_helper.add_keymaps(navigation_mappings)
  end
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  window_nav = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
  window_resize = { "<M-h>", "<M-j>", "<M-k>", "<M-l>" },
  buffer_nav = { "<TAB>", "<S-TAB>" },
  window_management = { "<Leader>wh", "<Leader>wv", "<Leader>wc", "<Leader>wo" },
  buffer_management = { "<Leader>bd", "<Leader>bn", "<Leader>bp" },
  tab_management = { "<Leader>tn", "<Leader>tc", "<Leader>th", "<Leader>tl" },
  quickfix = { "<Leader>qo", "<Leader>qn", "<Leader>qp" },
  location_list = { "<Leader>ll", "<Leader>ln", "<Leader>lp" },
  jump_navigation = { "<C-o>", "<C-i>" },
  fold_navigation = { "zj", "zk", "[z", "]z" },
}

return M