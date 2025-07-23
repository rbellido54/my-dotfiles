-- Comprehensive test for full configuration startup
-- This validates that all components work together correctly

local function test_full_configuration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Verify all Lua config modules loaded
  local config_modules = {"options", "keymaps", "autocmds"}
  for _, module in ipairs(config_modules) do
    local ok = pcall(require, "config." .. module)
    if ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Failed to load config.%s", module))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check critical vim options are set
  local critical_options = {
    leader = " ",  -- Leader key
    number = true,  -- Line numbers
    relativenumber = true,  -- Relative line numbers
    expandtab = true,  -- Expand tabs to spaces
    tabstop = 2,  -- Tab width
    shiftwidth = 2,  -- Indent width
    hidden = true,  -- Multiple buffers
    mouse = "a",  -- Mouse support
    clipboard = "unnamedplus",  -- System clipboard
  }

  -- Check leader key separately
  if vim.g.mapleader == " " then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Leader key not set to space")
    results.failed = results.failed + 1
  end

  -- Check other options
  for option, expected in pairs(critical_options) do
    if option ~= "leader" then  -- Skip leader as it's checked above
      local actual = vim.opt[option]:get()
      if actual == expected then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format(
          "Option %s: expected %s, got %s", 
          option, vim.inspect(expected), vim.inspect(actual)
        ))
        results.failed = results.failed + 1
      end
    end
  end

  -- Test 3: Check critical keymaps exist
  local critical_keymaps = {
    {"n", "<Tab>", "bnext"},     -- Buffer navigation
    {"n", "<S-Tab>", "bprevious"}, -- Buffer navigation
    {"n", "<C-S>", ":w<CR>"},    -- Save
    {"i", "jj", "<Esc>"},        -- Escape
    {"n", "<C-F>", ":Files<CR>"}, -- FZF files
  }

  for _, keymap_info in ipairs(critical_keymaps) do
    local mode, lhs, expected_rhs = keymap_info[1], keymap_info[2], keymap_info[3]
    local keymaps = vim.api.nvim_get_keymap(mode)
    local found = false
    
    for _, km in ipairs(keymaps) do
      if km.lhs == lhs and km.rhs and km.rhs:find(expected_rhs, 1, true) then
        found = true
        break
      end
    end
    
    if found then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format(
        "Keymap %s:%s not found or incorrect", mode, lhs
      ))
      results.failed = results.failed + 1
    end
  end

  -- Test 4: Check FZF configuration
  local fzf_vars = {
    "fzf_action",
    "fzf_history_dir",
    "fzf_layout",
    "fzf_colors",
  }

  for _, var in ipairs(fzf_vars) do
    if vim.g[var] then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("FZF variable g:%s not set", var))
      results.failed = results.failed + 1
    end
  end

  -- Test 5: Check autocommands exist
  local autocmds = vim.api.nvim_get_autocmds({
    event = "BufWritePost",
  })
  
  local found_init_autocmd = false
  for _, autocmd in ipairs(autocmds) do
    if autocmd.pattern and (autocmd.pattern:find("init") or autocmd.callback) then
      found_init_autocmd = true
      break
    end
  end
  
  if found_init_autocmd then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "BufWritePost autocmd for init file not found")
    results.failed = results.failed + 1
  end

  -- Test 6: Check theme is loaded
  if vim.g.colors_name and vim.g.colors_name ~= "" then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "No colorscheme loaded")
    results.failed = results.failed + 1
  end

  -- Test 7: Check airline is configured
  if vim.g.airline_theme then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Airline theme not configured")
    results.failed = results.failed + 1
  end

  -- Test 8: Check vim-plug commands exist
  if vim.fn.exists(":PlugInstall") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-plug commands not available")
    results.failed = results.failed + 1
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running full configuration test...")
  print("=" .. string.rep("=", 50))
  
  local results = test_full_configuration()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 50))
  
  local success = results.failed == 0
  if success then
    print("🎉 Full configuration test PASSED!")
  else
    print("❌ Full configuration test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_full_configuration = test_full_configuration,
  run_tests = run_tests
}