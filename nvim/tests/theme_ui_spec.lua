-- Tests for theme switching and UI plugin functionality
-- This test file verifies that themes and UI plugins work correctly with lazy.nvim

local function test_theme_plugins()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- List of expected theme plugins
  local theme_plugins = {
    "onedark.vim",
    "base16-vim", 
    "neon",
    "tokyonight.nvim",
    "nightfox.nvim",
    "everforest",
    "vim-deus",
    "oceanic-next",
    "kanagawa.nvim",
    "catppuccin",
    "gruvbox.nvim",
    "vim-paper",
    "eldritch.nvim"
  }

  -- Test 1: Check if theme plugins are installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  for _, plugin in ipairs(theme_plugins) do
    local plugin_path = lazy_path .. "/" .. plugin
    if vim.fn.isdirectory(plugin_path) == 1 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Theme plugin '%s' not found at %s", plugin, plugin_path))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check if a colorscheme is currently active
  local current_colorscheme = vim.g.colors_name
  if current_colorscheme and current_colorscheme ~= "" then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "No colorscheme is currently active")
    results.failed = results.failed + 1
  end

  return results
end

local function test_airline()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if airline plugins are installed
  local airline_plugins = { "vim-airline", "vim-airline-themes" }
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  
  for _, plugin in ipairs(airline_plugins) do
    local plugin_path = lazy_path .. "/" .. plugin
    if vim.fn.isdirectory(plugin_path) == 1 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Airline plugin '%s' not found", plugin))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check if airline is loaded
  if vim.g.loaded_airline == 1 then
    results.passed = results.passed + 1
  else
    -- Airline might not be loaded yet due to lazy loading
    table.insert(results.errors, "Airline not loaded (may be lazy loaded)")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if airline theme is configured
  if vim.g.airline_theme then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Airline theme not configured")
    results.failed = results.failed + 1
  end

  return results
end

local function test_web_devicons()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if nvim-web-devicons is installed
  local devicons_path = vim.fn.stdpath("data") .. "/lazy/nvim-web-devicons"
  if vim.fn.isdirectory(devicons_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-web-devicons plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Try to require web-devicons (it should be available)
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot require nvim-web-devicons: " .. tostring(devicons))
    results.failed = results.failed + 1
  end

  return results
end

local function test_colorizer()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if nvim-colorizer is installed
  local colorizer_path = vim.fn.stdpath("data") .. "/lazy/nvim-colorizer.lua"
  if vim.fn.isdirectory(colorizer_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-colorizer.lua plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if colorizer commands exist
  if vim.fn.exists(":ColorizerToggle") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":ColorizerToggle command not available")
    results.failed = results.failed + 1
  end

  return results
end

local function test_which_key()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if which-key is installed
  local whichkey_path = vim.fn.stdpath("data") .. "/lazy/which-key.nvim"
  if vim.fn.isdirectory(whichkey_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "which-key.nvim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Try to require which-key
  local ok = pcall(require, "which-key")
  if ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot require which-key (may be lazy loaded)")
    results.failed = results.failed + 1
  end

  return results
end

local function test_theme_ui_plugins()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test theme plugins
  local theme_results = test_theme_plugins()
  results.passed = results.passed + theme_results.passed
  results.failed = results.failed + theme_results.failed
  for _, error in ipairs(theme_results.errors) do
    table.insert(results.errors, "themes: " .. error)
  end

  -- Test airline
  local airline_results = test_airline()
  results.passed = results.passed + airline_results.passed
  results.failed = results.failed + airline_results.failed
  for _, error in ipairs(airline_results.errors) do
    table.insert(results.errors, "airline: " .. error)
  end

  -- Test web-devicons
  local devicons_results = test_web_devicons()
  results.passed = results.passed + devicons_results.passed
  results.failed = results.failed + devicons_results.failed
  for _, error in ipairs(devicons_results.errors) do
    table.insert(results.errors, "web-devicons: " .. error)
  end

  -- Test colorizer
  local colorizer_results = test_colorizer()
  results.passed = results.passed + colorizer_results.passed
  results.failed = results.failed + colorizer_results.failed
  for _, error in ipairs(colorizer_results.errors) do
    table.insert(results.errors, "colorizer: " .. error)
  end

  -- Test which-key
  local whichkey_results = test_which_key()
  results.passed = results.passed + whichkey_results.passed
  results.failed = results.failed + whichkey_results.failed
  for _, error in ipairs(whichkey_results.errors) do
    table.insert(results.errors, "which-key: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running theme and UI plugins functionality tests...")
  print("=" .. string.rep("=", 55))
  
  local results = test_theme_ui_plugins()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 55))
  
  local success = results.failed == 0
  if success then
    print("🎉 Theme and UI plugins test PASSED!")
  else
    print("❌ Theme and UI plugins test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_theme_plugins = test_theme_plugins,
  test_airline = test_airline,
  test_web_devicons = test_web_devicons,
  test_colorizer = test_colorizer,
  test_which_key = test_which_key,
  test_theme_ui_plugins = test_theme_ui_plugins,
  run_tests = run_tests
}