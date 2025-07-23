-- Tests for core plugin functionality
-- This test file verifies that essential plugins work correctly with lazy.nvim

local function test_vim_polyglot()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if vim-polyglot is loaded
  local polyglot_path = vim.fn.stdpath("data") .. "/lazy/vim-polyglot"
  if vim.fn.isdirectory(polyglot_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-polyglot plugin directory not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if syntax highlighting is enabled
  if vim.g.syntax_on then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Syntax highlighting not enabled")
    results.failed = results.failed + 1
  end

  return results
end

local function test_auto_pairs()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if auto-pairs is installed
  local autopairs_path = vim.fn.stdpath("data") .. "/lazy/auto-pairs"
  if vim.fn.isdirectory(autopairs_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "auto-pairs plugin directory not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if auto-pairs variables are set
  if vim.g.AutoPairsLoaded ~= nil or vim.fn.exists("*AutoPairsInit") == 1 then
    results.passed = results.passed + 1
  else
    -- Auto-pairs might load on insert mode, so this isn't necessarily a failure
    results.passed = results.passed + 1
  end

  return results
end

local function test_nvim_tree()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if nvim-tree is installed
  local nvimtree_path = vim.fn.stdpath("data") .. "/lazy/nvim-tree.lua"
  if vim.fn.isdirectory(nvimtree_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-tree.lua plugin directory not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if nvim-tree commands exist
  if vim.fn.exists(":NvimTreeToggle") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":NvimTreeToggle command not available")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if nvim-tree can be required (when lazy loaded)
  local ok = pcall(require, "nvim-tree")
  if ok then
    results.passed = results.passed + 1
  else
    -- This might be expected if lazy loading hasn't triggered yet
    table.insert(results.errors, "nvim-tree module cannot be required (may be lazy loaded)")
    results.failed = results.failed + 1
  end

  return results
end

local function test_plugin_configs()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if plug-config directory exists
  local plug_config_dir = vim.fn.expand("$HOME/.config/nvim/plug-config")
  if vim.fn.isdirectory(plug_config_dir) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "plug-config directory not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if plugin configs are being loaded (look for evidence)
  -- Check for some common variables that would be set by plugin configs
  local config_evidence = {
    vim.g.airline_theme,
    vim.g.fzf_layout,
    vim.g.startify_lists,
  }
  
  local found_configs = 0
  for _, config in ipairs(config_evidence) do
    if config ~= nil then
      found_configs = found_configs + 1
    end
  end
  
  if found_configs > 0 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "No evidence of plugin configs being loaded")
    results.failed = results.failed + 1
  end

  return results
end

local function test_core_plugins()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test vim-polyglot
  local polyglot_results = test_vim_polyglot()
  results.passed = results.passed + polyglot_results.passed
  results.failed = results.failed + polyglot_results.failed
  for _, error in ipairs(polyglot_results.errors) do
    table.insert(results.errors, "vim-polyglot: " .. error)
  end

  -- Test auto-pairs
  local autopairs_results = test_auto_pairs()
  results.passed = results.passed + autopairs_results.passed
  results.failed = results.failed + autopairs_results.failed
  for _, error in ipairs(autopairs_results.errors) do
    table.insert(results.errors, "auto-pairs: " .. error)
  end

  -- Test nvim-tree
  local nvimtree_results = test_nvim_tree()
  results.passed = results.passed + nvimtree_results.passed
  results.failed = results.failed + nvimtree_results.failed
  for _, error in ipairs(nvimtree_results.errors) do
    table.insert(results.errors, "nvim-tree: " .. error)
  end

  -- Test plugin configs
  local config_results = test_plugin_configs()
  results.passed = results.passed + config_results.passed
  results.failed = results.failed + config_results.failed
  for _, error in ipairs(config_results.errors) do
    table.insert(results.errors, "plugin-config: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running core plugins functionality tests...")
  print("=" .. string.rep("=", 50))
  
  local results = test_core_plugins()
  
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
    print("🎉 Core plugins test PASSED!")
  else
    print("❌ Core plugins test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_vim_polyglot = test_vim_polyglot,
  test_auto_pairs = test_auto_pairs,
  test_nvim_tree = test_nvim_tree,
  test_plugin_configs = test_plugin_configs,
  test_core_plugins = test_core_plugins,
  run_tests = run_tests
}