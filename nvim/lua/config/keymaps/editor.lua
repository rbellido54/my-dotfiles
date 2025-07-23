-- config/keymaps/editor.lua
-- Text editing and manipulation keymaps
-- These keymaps enhance text editing experience with modern Vim patterns

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
  
  -- Define editor keymaps with descriptions
  local editor_mappings = {
    -- Better indentation in visual mode
    { "<", "<gv", desc = "Indent left and reselect", mode = "v" },
    { ">", ">gv", desc = "Indent right and reselect", mode = "v" },
    
    -- Move lines up/down in visual mode
    { "J", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },
    { "K", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "v" },
    
    -- Quick line insertion without entering insert mode
    { "<Leader>o", "o<Esc>^Da", desc = "Insert line below", mode = "n" },
    { "<Leader>O", "O<Esc>^Da", desc = "Insert line above", mode = "n" },
    
    -- Better paste behavior
    { "<Leader>p", '"_dP', desc = "Paste without yanking", mode = "v" },
    
    -- System clipboard integration
    { "<Leader>y", '"+y', desc = "Yank to system clipboard", mode = { "n", "v" } },
    { "<Leader>Y", '"+Y', desc = "Yank line to system clipboard", mode = "n" },
    { "<Leader>P", '"+p', desc = "Paste from system clipboard", mode = { "n", "v" } },
    
    -- Delete without yanking
    { "<Leader>d", '"_d', desc = "Delete without yanking", mode = { "n", "v" } },
    
    -- Replace word under cursor
    { "<Leader>r", ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', desc = "Replace word under cursor", mode = "n" },
    
    -- Quick substitute
    { "<Leader>s", ":%s/", desc = "Substitute in file", mode = "n" },
    { "<Leader>s", ":s/", desc = "Substitute in selection", mode = "v" },
    
    -- Format paragraph
    { "<Leader>F", "gqap", desc = "Format paragraph", mode = "n" },
    
    -- Select all
    { "<C-a>", "ggVG", desc = "Select all", mode = "n" },
    
    -- Keep cursor centered when jumping
    { "<C-d>", "<C-d>zz", desc = "Half page down (centered)", mode = "n" },
    { "<C-u>", "<C-u>zz", desc = "Half page up (centered)", mode = "n" },
    { "n", "nzzzv", desc = "Next search result (centered)", mode = "n" },
    { "N", "Nzzzv", desc = "Previous search result (centered)", mode = "n" },
    
    -- Better completion navigation in insert mode
    { "<C-j>", "<C-n>", desc = "Next completion item", mode = "i", expr = true },
    { "<C-k>", "<C-p>", desc = "Previous completion item", mode = "i", expr = true },
    
    -- Smart tab completion
    { "<TAB>", function()
        return vim.fn.pumvisible() == 1 and "<C-n>" or "<TAB>"
      end, 
      desc = "Smart tab completion", 
      mode = "i", 
      expr = true 
    },
    
    -- Clear search highlights
    { "<Leader>h", "<cmd>nohlsearch<CR>", desc = "Clear search highlights", mode = "n" },
    
    -- Source current file (useful for Lua config development)
    { "<Leader><Leader>s", "<cmd>source %<CR>", desc = "Source current file", mode = "n" },
    
    -- Make file executable
    { "<Leader>x", "<cmd>!chmod +x %<CR>", desc = "Make file executable", mode = "n", silent = false },
    
    -- Text object enhancements
    { "<Leader>j", "J", desc = "Join lines", mode = "n" },
    
    -- Quick word boundaries
    { "W", "B", desc = "Previous WORD", mode = "n" },
    { "E", "gE", desc = "End of previous WORD", mode = "n" },
    
    -- Duplicate line
    { "<Leader>D", "yyp", desc = "Duplicate line", mode = "n" },
    { "<Leader>D", "y'>p", desc = "Duplicate selection", mode = "v" },
    
    -- Quick marks
    { "<Leader>m", "m", desc = "Set mark", mode = "n" },
    { "<Leader>'", "'", desc = "Jump to mark", mode = "n" },
    
    -- Text case conversion
    { "<Leader>u", "guu", desc = "Lowercase line", mode = "n" },
    { "<Leader>U", "gUU", desc = "Uppercase line", mode = "n" },
    { "<Leader>u", "gu", desc = "Lowercase selection", mode = "v" },
    { "<Leader>U", "gU", desc = "Uppercase selection", mode = "v" },
    
    -- Spell checking
    { "<Leader>z", "z=", desc = "Spell suggest", mode = "n" },
    { "<Leader>zg", "zg", desc = "Add word to dictionary", mode = "n" },
    { "<Leader>zb", "zb", desc = "Mark word as bad", mode = "n" },
    
    -- Increment/decrement numbers
    { "<Leader>+", "<C-a>", desc = "Increment number", mode = "n" },
    { "<Leader>-", "<C-x>", desc = "Decrement number", mode = "n" },
    { "<Leader>+", "g<C-a>", desc = "Increment numbers (sequential)", mode = "v" },
    { "<Leader>-", "g<C-x>", desc = "Decrement numbers (sequential)", mode = "v" },
  }
  
  -- Register keymaps - always register manually first, then enhance with which-key
  for _, mapping in ipairs(editor_mappings) do
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
    wk_helper.add_keymaps(editor_mappings)
  end
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  visual_helpers = { "<", ">", "J", "K" },
  line_operations = { "<Leader>o", "<Leader>O", "<Leader>D" },
  clipboard = { "<Leader>y", "<Leader>Y", "<Leader>P", "<Leader>p", "<Leader>d" },
  text_manipulation = { "<Leader>r", "<Leader>s", "<Leader>F" },
  navigation_helpers = { "<C-d>", "<C-u>", "n", "N" },
  completion = { "<C-j>", "<C-k>", "<TAB>" },
  utility = { "<Leader>h", "<Leader>x", "<Leader><Leader>s" },
  case_conversion = { "<Leader>u", "<Leader>U" },
  spell_check = { "<Leader>z", "<Leader>zg", "<Leader>zb" },
  numbers = { "<Leader>+", "<Leader>-" },
}

return M