-- Tests for lua/config/keymaps.lua
-- This test file verifies that all key mappings are set correctly

local function get_keymap(mode, lhs)
  local keymaps = vim.api.nvim_get_keymap(mode)
  for _, keymap in ipairs(keymaps) do
    if keymap.lhs == lhs then
      return keymap
    end
  end
  return nil
end

local function test_keymaps()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Expected keymaps based on keys/mappings.vim
  local expected_keymaps = {
    -- Normal mode mappings
    n = {
      -- Window resizing
      ["<M-j>"] = ":resize -2<CR>",
      ["<M-k>"] = ":resize +2<CR>",
      ["<M-h>"] = ":vertical resize -2<CR>",
      ["<M-l>"] = ":vertical resize +2<CR>",
      
      -- Buffer navigation
      ["<Tab>"] = ":bnext<CR>",
      ["<S-Tab>"] = ":bprevious<CR>",
      
      -- Save and quit
      ["<C-S>"] = ":w<CR>",
      ["<C-Q>"] = ":wq!<CR>",
      ["<C-C>"] = "<Esc>",
      
      -- Window navigation
      ["<C-H>"] = "<C-W>h",
      ["<C-J>"] = "<C-W>j",
      ["<C-K>"] = "<C-W>k",
      ["<C-L>"] = "<C-W>l",
      
      -- Leader mappings
      ["<Space>o"] = "o<Esc>^Da",
      ["<Space>O"] = "O<Esc>^Da",
      
      -- FZF
      ["<C-F>"] = ":Files<CR>",
    },
    
    -- Insert mode mappings
    i = {
      -- Escape alternatives
      ["jj"] = "<Esc>",
      ["<C-C>"] = "<Esc>",
      
      -- Completion navigation
      ["<C-J>"] = "<C-N>",
      ["<C-K>"] = "<C-P>",
    },
    
    -- Visual mode mappings
    v = {
      -- Better indenting
      ["<"] = "<gv",
      [">"] = ">gv",
    }
  }

  -- Test each keymap
  for mode, mappings in pairs(expected_keymaps) do
    for lhs, expected_rhs in pairs(mappings) do
      local keymap = get_keymap(mode, lhs)
      
      if keymap then
        -- Check if the mapping exists and has expected behavior
        -- Note: We check if the expected_rhs is contained in the actual mapping
        -- because Neovim might add additional flags or modify the command
        if keymap.rhs and (keymap.rhs == expected_rhs or keymap.rhs:find(expected_rhs:gsub("%-", "%%-"):gsub("<", "%%<"):gsub(">", "%%>"), 1, true)) then
          results.passed = results.passed + 1
        else
          table.insert(results.errors, string.format(
            "Keymap '%s' in mode '%s': expected rhs containing '%s', got '%s'",
            lhs, mode, expected_rhs, keymap.rhs or "nil"
          ))
          results.failed = results.failed + 1
        end
      else
        table.insert(results.errors, string.format(
          "Keymap '%s' in mode '%s' not found",
          lhs, mode
        ))
        results.failed = results.failed + 1
      end
    end
  end

  -- Test FZF configuration variables
  local fzf_vars = {
    fzf_action = vim.g.fzf_action,
    fzf_history_dir = vim.g.fzf_history_dir,
    fzf_layout = vim.g.fzf_layout,
    fzf_colors = vim.g.fzf_colors,
  }
  
  -- Basic check that FZF variables are set
  for var_name, var_value in pairs(fzf_vars) do
    if var_value ~= nil then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("FZF variable 'g:%s' is not set", var_name))
      results.failed = results.failed + 1
    end
  end

  -- Test FZF environment variables
  if vim.env.FZF_DEFAULT_OPTS then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "FZF_DEFAULT_OPTS environment variable is not set")
    results.failed = results.failed + 1
  end
  
  if vim.env.FZF_DEFAULT_COMMAND then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "FZF_DEFAULT_COMMAND environment variable is not set")
    results.failed = results.failed + 1
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running keymap tests...")
  print("=" .. string.rep("=", 50))
  
  local results = test_keymaps()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 50))
  
  return results.failed == 0
end

-- Export for external use
return {
  test_keymaps = test_keymaps,
  run_tests = run_tests
}