-- Tests for performance benchmarking and startup time measurement
-- This test file verifies startup performance and plugin loading efficiency

local function measure_startup_time()
  local results = {
    passed = 0,
    failed = 0,
    errors = {},
    metrics = {}
  }

  -- Test 1: Check if lazy.nvim is loaded and ready
  local lazy_loaded = pcall(require, "lazy")
  if lazy_loaded then
    results.passed = results.passed + 1
    results.metrics.lazy_loaded = true
  else
    table.insert(results.errors, "lazy.nvim not loaded properly")
    results.failed = results.failed + 1
    results.metrics.lazy_loaded = false
  end

  -- Test 2: Measure plugin loading time
  local start_time = vim.fn.reltime()
  local lazy = require("lazy")
  local stats = lazy.stats()
  local load_time = vim.fn.reltimefloat(vim.fn.reltime(start_time)) * 1000

  results.metrics.plugin_load_time = string.format("%.2f", load_time)
  results.metrics.total_plugins = stats.count
  results.metrics.loaded_plugins = stats.loaded
  results.metrics.startup_time = stats.startuptime

  if load_time < 100 then -- Less than 100ms for plugin system initialization
    results.passed = results.passed + 1
  else
    table.insert(results.errors, string.format("Plugin loading time too high: %.2fms", load_time))
    results.failed = results.failed + 1
  end

  -- Test 3: Check lazy loading effectiveness
  local lazy_plugins = 0
  local eager_plugins = 0
  
  for _, plugin in pairs(lazy.plugins()) do
    if plugin.lazy == false or plugin.lazy == nil then
      eager_plugins = eager_plugins + 1
    else
      lazy_plugins = lazy_plugins + 1
    end
  end

  results.metrics.lazy_plugins = lazy_plugins
  results.metrics.eager_plugins = eager_plugins
  results.metrics.lazy_ratio = string.format("%.1f", (lazy_plugins / (lazy_plugins + eager_plugins)) * 100)

  if lazy_plugins > eager_plugins then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Not enough plugins are lazy loaded")
    results.failed = results.failed + 1
  end

  return results
end

local function test_memory_usage()
  local results = {
    passed = 0,
    failed = 0,
    errors = {},
    metrics = {}
  }

  -- Test 1: Check Lua memory usage
  local memory_kb = collectgarbage("count")
  results.metrics.lua_memory_kb = string.format("%.1f", memory_kb)

  if memory_kb < 10000 then -- Less than 10MB for Lua memory
    results.passed = results.passed + 1
  else
    table.insert(results.errors, string.format("Lua memory usage too high: %.1fKB", memory_kb))
    results.failed = results.failed + 1
  end

  -- Test 2: Check if disabled plugins are actually disabled
  local disabled_plugins = {
    "gzip", "matchit", "matchparen", "netrwPlugin", 
    "tarPlugin", "tohtml", "tutor", "zipPlugin"
  }

  local disabled_count = 0
  for _, plugin in ipairs(disabled_plugins) do
    if vim.g["loaded_" .. plugin] == 1 then
      disabled_count = disabled_count + 1
    end
  end

  results.metrics.disabled_plugins = disabled_count
  results.metrics.total_disabled_expected = #disabled_plugins

  if disabled_count == 0 then -- All plugins should be disabled
    results.passed = results.passed + 1
  else
    table.insert(results.errors, string.format("%d default plugins not properly disabled", disabled_count))
    results.failed = results.failed + 1
  end

  return results
end

local function test_plugin_performance()
  local results = {
    passed = 0,
    failed = 0,
    errors = {},
    metrics = {}
  }

  -- Test 1: Check critical plugins are loaded immediately
  local critical_plugins = {
    "nightfox.nvim", -- Theme should be loaded immediately
  }

  local loaded_critical = 0
  for _, plugin_name in ipairs(critical_plugins) do
    local plugin_path = vim.fn.stdpath("data") .. "/lazy/" .. plugin_name
    if vim.fn.isdirectory(plugin_path) == 1 then
      loaded_critical = loaded_critical + 1
    end
  end

  results.metrics.critical_plugins_loaded = loaded_critical
  results.metrics.critical_plugins_expected = #critical_plugins

  if loaded_critical == #critical_plugins then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Critical plugins not loaded")
    results.failed = results.failed + 1
  end

  -- Test 2: Verify lazy loading for non-critical plugins
  local lazy_load_plugins = {
    "mason.nvim", -- Should be loaded on command
    "fzf.vim", -- Should be loaded on key press
    "vim-fugitive", -- Should be loaded on git command
  }

  -- These should be installed but not necessarily loaded yet
  local installed_lazy = 0
  for _, plugin_name in ipairs(lazy_load_plugins) do
    local plugin_path = vim.fn.stdpath("data") .. "/lazy/" .. plugin_name
    if vim.fn.isdirectory(plugin_path) == 1 then
      installed_lazy = installed_lazy + 1
    end
  end

  results.metrics.lazy_plugins_installed = installed_lazy
  results.metrics.lazy_plugins_expected = #lazy_load_plugins

  if installed_lazy == #lazy_load_plugins then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Lazy loading plugins not properly installed")
    results.failed = results.failed + 1
  end

  -- Test 3: Check plugin manager efficiency
  local lazy = require("lazy")
  local stats = lazy.stats()
  
  results.metrics.total_plugins = stats.count
  results.metrics.loaded_at_startup = stats.loaded

  -- Should load minimal plugins at startup
  if stats.loaded < (stats.count * 0.3) then -- Less than 30% loaded at startup
    results.passed = results.passed + 1
  else
    table.insert(results.errors, string.format("Too many plugins loaded at startup: %d/%d", stats.loaded, stats.count))
    results.failed = results.failed + 1
  end

  return results
end

local function test_configuration_loading()
  local results = {
    passed = 0,
    failed = 0,
    errors = {},
    metrics = {}
  }

  -- Test 1: Check if all config modules loaded
  local config_modules = { "config.options", "config.keymaps", "config.autocmds" }
  local loaded_modules = 0

  for _, module in ipairs(config_modules) do
    local ok = pcall(require, module)
    if ok then
      loaded_modules = loaded_modules + 1
    end
  end

  results.metrics.config_modules_loaded = loaded_modules
  results.metrics.config_modules_expected = #config_modules

  if loaded_modules == #config_modules then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Not all config modules loaded properly")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if colorscheme is applied
  if vim.g.colors_name and vim.g.colors_name ~= "" then
    results.passed = results.passed + 1
    results.metrics.colorscheme = vim.g.colors_name
  else
    table.insert(results.errors, "No colorscheme applied")
    results.failed = results.failed + 1
    results.metrics.colorscheme = "none"
  end

  return results
end

local function test_performance_comprehensive()
  local results = {
    passed = 0,
    failed = 0,
    errors = {},
    metrics = {}
  }

  -- Test startup time measurement
  local startup_results = measure_startup_time()
  results.passed = results.passed + startup_results.passed
  results.failed = results.failed + startup_results.failed
  for _, error in ipairs(startup_results.errors) do
    table.insert(results.errors, "startup: " .. error)
  end
  for k, v in pairs(startup_results.metrics) do
    results.metrics["startup_" .. k] = v
  end

  -- Test memory usage
  local memory_results = test_memory_usage()
  results.passed = results.passed + memory_results.passed
  results.failed = results.failed + memory_results.failed
  for _, error in ipairs(memory_results.errors) do
    table.insert(results.errors, "memory: " .. error)
  end
  for k, v in pairs(memory_results.metrics) do
    results.metrics["memory_" .. k] = v
  end

  -- Test plugin performance
  local plugin_results = test_plugin_performance()
  results.passed = results.passed + plugin_results.passed
  results.failed = results.failed + plugin_results.failed
  for _, error in ipairs(plugin_results.errors) do
    table.insert(results.errors, "plugins: " .. error)
  end
  for k, v in pairs(plugin_results.metrics) do
    results.metrics["plugins_" .. k] = v
  end

  -- Test configuration loading
  local config_results = test_configuration_loading()
  results.passed = results.passed + config_results.passed
  results.failed = results.failed + config_results.failed
  for _, error in ipairs(config_results.errors) do
    table.insert(results.errors, "config: " .. error)
  end
  for k, v in pairs(config_results.metrics) do
    results.metrics["config_" .. k] = v
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running performance benchmarking tests...")
  print("=" .. string.rep("=", 45))
  
  local results = test_performance_comprehensive()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  -- Display metrics
  print("\nPerformance Metrics:")
  print("-------------------")
  for key, value in pairs(results.metrics) do
    print(string.format("%-25s: %s", key, tostring(value)))
  end
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 45))
  
  local success = results.failed == 0
  if success then
    print("🎉 Performance benchmarking test PASSED!")
  else
    print("❌ Performance benchmarking test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  measure_startup_time = measure_startup_time,
  test_memory_usage = test_memory_usage,
  test_plugin_performance = test_plugin_performance,
  test_configuration_loading = test_configuration_loading,
  test_performance_comprehensive = test_performance_comprehensive,
  run_tests = run_tests
}