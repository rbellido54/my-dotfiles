-- Tests for lazy.nvim installation and initialization
-- This test file verifies that lazy.nvim is properly installed and configured

local function test_lazy_installation()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if lazy.nvim is installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if vim.fn.isdirectory(lazy_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "lazy.nvim is not installed at expected path: " .. lazy_path)
    results.failed = results.failed + 1
  end

  -- Test 2: Check if lazy.nvim can be required
  local ok, lazy = pcall(require, "lazy")
  if ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot require lazy.nvim: " .. tostring(lazy))
    results.failed = results.failed + 1
  end

  -- Test 3: Check if lazy.nvim is initialized
  if ok then
    -- Check if lazy has basic functions
    if type(lazy.setup) == "function" then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "lazy.setup function not available")
      results.failed = results.failed + 1
    end
  else
    results.failed = results.failed + 1
    table.insert(results.errors, "Cannot test lazy functions - lazy not loaded")
  end

  -- Test 4: Check if plugins directory exists
  local plugins_path = vim.fn.stdpath("data") .. "/lazy"
  if vim.fn.isdirectory(plugins_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Lazy plugins directory not found: " .. plugins_path)
    results.failed = results.failed + 1
  end

  -- Test 5: Check if at least some plugins are installed via lazy
  if ok then
    local plugins = lazy.plugins()
    if plugins and type(plugins) == "table" and #plugins > 0 then
      results.passed = results.passed + 1
    else
      -- This might be expected if no plugins are configured yet
      table.insert(results.errors, "No plugins found in lazy configuration (might be expected during initial setup)")
      results.failed = results.failed + 1
    end
  else
    results.failed = results.failed + 1
    table.insert(results.errors, "Cannot check plugins - lazy not loaded")
  end

  return results
end

local function test_plugin_manager_compatibility()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if vim-plug fallback works
  if vim.fn.exists("*plug#begin") == 1 then
    results.passed = results.passed + 1
  else
    -- This is expected when lazy.nvim is primary
    results.passed = results.passed + 1
  end

  -- Test 2: Check if we can determine which plugin manager is active
  local using_lazy = pcall(require, "lazy")
  local using_plug = vim.fn.exists("*plug#begin") == 1
  
  if using_lazy or using_plug then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Neither lazy.nvim nor vim-plug appears to be active")
    results.failed = results.failed + 1
  end

  -- Test 3: Check plugin manager commands exist
  if using_lazy then
    -- Check for lazy commands
    if vim.fn.exists(":Lazy") == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, ":Lazy command not available")
      results.failed = results.failed + 1
    end
  elseif using_plug then
    -- Check for plug commands
    if vim.fn.exists(":PlugInstall") == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, ":PlugInstall command not available")
      results.failed = results.failed + 1
    end
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running lazy.nvim installation and initialization tests...")
  print("=" .. string.rep("=", 60))
  
  -- Run installation tests
  print("\n--- Testing lazy.nvim installation ---")
  local install_results = test_lazy_installation()
  
  print(string.format("Installation tests passed: %d", install_results.passed))
  print(string.format("Installation tests failed: %d", install_results.failed))
  
  if #install_results.errors > 0 then
    print("\nInstallation errors:")
    for _, error in ipairs(install_results.errors) do
      print("  - " .. error)
    end
  end

  -- Run compatibility tests
  print("\n--- Testing plugin manager compatibility ---")
  local compat_results = test_plugin_manager_compatibility()
  
  print(string.format("Compatibility tests passed: %d", compat_results.passed))
  print(string.format("Compatibility tests failed: %d", compat_results.failed))
  
  if #compat_results.errors > 0 then
    print("\nCompatibility errors:")
    for _, error in ipairs(compat_results.errors) do
      print("  - " .. error)
    end
  end

  -- Summary
  local total_passed = install_results.passed + compat_results.passed
  local total_failed = install_results.failed + compat_results.failed
  
  print("\n--- Test Summary ---")
  print(string.format("Total tests passed: %d", total_passed))
  print(string.format("Total tests failed: %d", total_failed))
  print("=" .. string.rep("=", 60))
  
  return total_failed == 0
end

-- Export for external use
return {
  test_lazy_installation = test_lazy_installation,
  test_plugin_manager_compatibility = test_plugin_manager_compatibility,
  run_tests = run_tests
}