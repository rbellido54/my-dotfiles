-- Tests for keymap modernization system
-- This test file verifies that the new modular keymap system works correctly

local function test_keymap_module_structure()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if keymap init module can be loaded
  local ok, keymap_module = pcall(require, "config.keymaps.init")
  if ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot load keymap init module: " .. tostring(keymap_module))
    results.failed = results.failed + 1
  end

  -- Test 2: Check if keymap module has expected functions
  if ok and keymap_module then
    local expected_functions = { "setup", "get_stats", "set_debug", "reload" }
    for _, func_name in ipairs(expected_functions) do
      if type(keymap_module[func_name]) == "function" then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Keymap module missing function: %s", func_name))
        results.failed = results.failed + 1
      end
    end
  end

  -- Test 3: Check if core keymap modules exist
  local core_modules = { "core", "editor", "navigation", "themes" }
  for _, module_name in ipairs(core_modules) do
    local module_ok, module = pcall(require, "config.keymaps." .. module_name)
    if module_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Cannot load " .. module_name .. " keymap module: " .. tostring(module))
      results.failed = results.failed + 1
    end
  end

  -- Test 4: Check if which-key integration module exists
  local wk_ok, wk_module = pcall(require, "config.keymaps.which-key-integration")
  if wk_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot load which-key integration module: " .. tostring(wk_module))
    results.failed = results.failed + 1
  end

  -- Test 5: Check if which-key integration has expected functions
  if wk_ok and wk_module then
    local expected_wk_functions = { "setup", "add_keymaps", "get_status" }
    for _, func_name in ipairs(expected_wk_functions) do
      if type(wk_module[func_name]) == "function" then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("which-key integration missing function: %s", func_name))
        results.failed = results.failed + 1
      end
    end
  end

  return results
end

local function test_keymap_initialization()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Initialize the keymap system
  local ok, keymap_module = pcall(require, "config.keymaps.init")
  if ok then
    local init_ok, init_result = pcall(keymap_module.setup)
    if init_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to initialize keymap system: " .. tostring(init_result))
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot load keymap module for initialization")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check if stats are available after initialization
  if ok and keymap_module then
    local stats = keymap_module.get_stats()
    if type(stats) == "table" then
      results.passed = results.passed + 1
      
      -- Check if stats have expected fields
      local expected_stats = { "core_modules", "plugin_modules", "which_key_loaded", "fallback_used" }
      for _, stat_name in ipairs(expected_stats) do
        if stats[stat_name] ~= nil then
          results.passed = results.passed + 1
        else
          table.insert(results.errors, string.format("Missing stat: %s", stat_name))
          results.failed = results.failed + 1
        end
      end
    else
      table.insert(results.errors, "get_stats() did not return a table")
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_editor_keymaps_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Load and setup editor keymaps
  local ok, editor_module = pcall(require, "config.keymaps.editor")
  if ok then
    local setup_ok, setup_result = pcall(editor_module.setup)
    if setup_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to setup editor keymaps: " .. tostring(setup_result))
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot load editor keymap module")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check if essential editor keymaps are registered
  local essential_editor_keymaps = {
    { key = "<", mode = "v" },        -- Indent left
    { key = ">", mode = "v" },        -- Indent right
    { key = "<Leader>y", mode = "n" }, -- Yank to clipboard
    { key = "<Leader>p", mode = "v" }, -- Paste without yanking
  }
  
  for _, keymap_config in ipairs(essential_editor_keymaps) do
    local keymap_info = vim.fn.maparg(keymap_config.key, keymap_config.mode, false, true)
    if type(keymap_info) == "table" and keymap_info.lhs then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Essential editor keymap not found: %s in mode %s", keymap_config.key, keymap_config.mode))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if editor module exports keymap categories
  if ok and editor_module.keymaps then
    local expected_categories = { "visual_helpers", "clipboard", "text_manipulation", "navigation_helpers" }
    for _, category in ipairs(expected_categories) do
      if editor_module.keymaps[category] then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Missing editor keymap category: %s", category))
        results.failed = results.failed + 1
      end
    end
  else
    table.insert(results.errors, "Editor module does not export keymap categories")
    results.failed = results.failed + 1
  end

  return results
end

local function test_themes_keymaps_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Load and setup themes keymaps
  local ok, themes_module = pcall(require, "config.keymaps.themes")
  if ok then
    local setup_ok, setup_result = pcall(themes_module.setup)
    if setup_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to setup themes keymaps: " .. tostring(setup_result))
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot load themes keymap module")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check if essential theme keymaps are registered
  local essential_theme_keymaps = {
    { key = "<leader>th", mode = "n" },     -- Theme browser
    { key = "<leader>t1", mode = "n" },     -- Quick theme switch
    { key = "<leader>ti", mode = "n" },     -- Theme info
    { key = "<leader>tb", mode = "n" },     -- Background toggle
  }
  
  for _, keymap_config in ipairs(essential_theme_keymaps) do
    local keymap_info = vim.fn.maparg(keymap_config.key, keymap_config.mode, false, true)
    if type(keymap_info) == "table" and keymap_info.lhs then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Essential theme keymap not found: %s in mode %s", keymap_config.key, keymap_config.mode))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if themes module exports required functions
  if ok and themes_module then
    local expected_exports = { "get_current_theme", "apply_theme", "themes" }
    for _, export in ipairs(expected_exports) do
      if themes_module[export] then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Missing theme module export: %s", export))
        results.failed = results.failed + 1
      end
    end
  end

  -- Test 4: Check if themes module exports keymap categories
  if ok and themes_module.keymaps then
    local expected_categories = { "browser", "quick_switch", "toggles", "navigation" }
    for _, category in ipairs(expected_categories) do
      if themes_module.keymaps[category] then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Missing theme keymap category: %s", category))
        results.failed = results.failed + 1
      end
    end
  else
    table.insert(results.errors, "Themes module does not export keymap categories")
    results.failed = results.failed + 1
  end

  return results
end

local function test_navigation_keymaps_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Load and setup navigation keymaps
  local ok, nav_module = pcall(require, "config.keymaps.navigation")
  if ok then
    local setup_ok, setup_result = pcall(nav_module.setup)
    if setup_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to setup navigation keymaps: " .. tostring(setup_result))
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot load navigation keymap module")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check if essential navigation keymaps are registered
  local essential_nav_keymaps = {
    { key = "<C-h>", mode = "n" },     -- Move to left window
    { key = "<C-l>", mode = "n" },     -- Move to right window
    { key = "<TAB>", mode = "n" },     -- Next buffer
    { key = "<S-TAB>", mode = "n" },   -- Previous buffer
  }
  
  for _, keymap_config in ipairs(essential_nav_keymaps) do
    local keymap_info = vim.fn.maparg(keymap_config.key, keymap_config.mode, false, true)
    if type(keymap_info) == "table" and keymap_info.lhs then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Essential navigation keymap not found: %s in mode %s", keymap_config.key, keymap_config.mode))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if navigation module exports keymap categories
  if ok and nav_module.keymaps then
    local expected_categories = { "window_nav", "buffer_nav", "window_management", "buffer_management" }
    for _, category in ipairs(expected_categories) do
      if nav_module.keymaps[category] then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Missing navigation keymap category: %s", category))
        results.failed = results.failed + 1
      end
    end
  else
    table.insert(results.errors, "Navigation module does not export keymap categories")
    results.failed = results.failed + 1
  end

  return results
end

local function test_core_keymaps_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Load and setup core keymaps
  local ok, core_module = pcall(require, "config.keymaps.core")
  if ok then
    local setup_ok, setup_result = pcall(core_module.setup)
    if setup_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to setup core keymaps: " .. tostring(setup_result))
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot load core keymap module")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check if essential keymaps are registered
  local essential_keymaps = {
    { key = "jj", mode = "i" },     -- Insert mode escape
    { key = "<C-s>", mode = "n" },  -- Save file
    { key = "<C-c>", mode = "n" },  -- Alternative escape
    { key = "<Leader>w", mode = "n" } -- Save all buffers
  }
  
  for _, keymap_config in ipairs(essential_keymaps) do
    local keymap_info = vim.fn.maparg(keymap_config.key, keymap_config.mode, false, true)
    if type(keymap_info) == "table" and keymap_info.lhs then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Essential keymap not found: %s in mode %s", keymap_config.key, keymap_config.mode))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if core module exports keymap categories
  if ok and core_module.keymaps then
    local expected_categories = { "essential", "save_quit", "help", "undo_redo", "movement" }
    for _, category in ipairs(expected_categories) do
      if core_module.keymaps[category] then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Missing core keymap category: %s", category))
        results.failed = results.failed + 1
      end
    end
  else
    table.insert(results.errors, "Core module does not export keymap categories")
    results.failed = results.failed + 1
  end

  return results
end

local function test_which_key_integration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Load which-key integration module
  local ok, wk_module = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Cannot load which-key integration module")
    results.failed = results.failed + 1
    return results
  end

  -- Test 2: Check which-key status
  if ok and wk_module then
    local status = wk_module.get_status()
    if type(status) == "table" then
      results.passed = results.passed + 1
      
      -- Check if status has expected fields
      local expected_fields = { "available", "configured" }
      for _, field in ipairs(expected_fields) do
        if status[field] ~= nil then
          results.passed = results.passed + 1
        else
          table.insert(results.errors, string.format("Missing status field: %s", field))
          results.failed = results.failed + 1
        end
      end
    else
      table.insert(results.errors, "get_status() did not return a table")
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Test add_keymaps function
  if ok and wk_module then
    local test_mapping = {
      { "<leader>test", "<cmd>echo 'test'<cr>", desc = "Test mapping" }
    }
    
    local add_ok, add_result = pcall(wk_module.add_keymaps, test_mapping)
    if add_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Failed to add test keymaps: " .. tostring(add_result))
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_plugin_modules_structure()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test plugin modules can be loaded (even if plugins aren't available)
  local plugin_modules = { "git", "fzf", "lsp", "ai", "terminal" }
  for _, module_name in ipairs(plugin_modules) do
    local module_ok, module = pcall(require, "config.keymaps." .. module_name)
    if module_ok then
      results.passed = results.passed + 1
      
      -- Check if module has setup function
      if type(module.setup) == "function" then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Plugin module %s missing setup function", module_name))
        results.failed = results.failed + 1
      end
      
      -- Check if module exports keymaps
      if module.keymaps and type(module.keymaps) == "table" then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Plugin module %s missing keymaps export", module_name))
        results.failed = results.failed + 1
      end
    else
      table.insert(results.errors, "Cannot load " .. module_name .. " plugin module: " .. tostring(module))
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_plugin_modules_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test each plugin module's setup function (should handle missing plugins gracefully)
  local plugin_modules = {
    { name = "git", categories = { "fugitive_core", "signify_nav", "lazygit" } },
    { name = "fzf", categories = { "file_finding", "content_search", "commands" } },
    { name = "lsp", categories = { "navigation", "actions", "diagnostics" } },
    { name = "ai", categories = { "copilot_control", "chat_basic", "workflow" } },
    { name = "terminal", categories = { "floaterm_basic", "native_terminal", "workflow" } },
  }
  
  for _, module_config in ipairs(plugin_modules) do
    local module_ok, module = pcall(require, "config.keymaps." .. module_config.name)
    if module_ok then
      -- Test setup function doesn't crash (even without plugins)
      local setup_ok, setup_result = pcall(module.setup)
      if setup_ok then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("Plugin module %s setup failed: %s", module_config.name, tostring(setup_result)))
        results.failed = results.failed + 1
      end
      
      -- Test keymap categories exist
      if module.keymaps then
        for _, category in ipairs(module_config.categories) do
          if module.keymaps[category] then
            results.passed = results.passed + 1
          else
            table.insert(results.errors, string.format("Missing keymap category %s in %s module", category, module_config.name))
            results.failed = results.failed + 1
          end
        end
      end
    end
  end

  return results
end

local function test_conditional_loading()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if keymap system properly handles missing plugins
  local ok, keymap_module = pcall(require, "config.keymaps.init")
  if ok then
    -- Test with debug mode enabled to see loading details
    keymap_module.set_debug(true)
    
    local setup_ok, setup_result = pcall(keymap_module.setup)
    if setup_ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Setup failed with debug mode: " .. tostring(setup_result))
      results.failed = results.failed + 1
    end
    
    -- Disable debug mode
    keymap_module.set_debug(false)
  else
    table.insert(results.errors, "Cannot load keymap module for conditional loading test")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if plugin modules are defined
  if ok and keymap_module then
    if keymap_module.plugin_modules and type(keymap_module.plugin_modules) == "table" then
      results.passed = results.passed + 1
      
      -- Check if plugin modules have required structure
      for _, plugin_config in ipairs(keymap_module.plugin_modules) do
        if plugin_config.module and plugin_config.plugins and plugin_config.description then
          results.passed = results.passed + 1
        else
          table.insert(results.errors, "Plugin module config missing required fields")
          results.failed = results.failed + 1
        end
      end
    else
      table.insert(results.errors, "Plugin modules not properly defined")
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if core modules are defined
  if ok and keymap_module then
    if keymap_module.core_modules and type(keymap_module.core_modules) == "table" then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "Core modules not properly defined")
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_keymap_modernization()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test module structure
  local structure_results = test_keymap_module_structure()
  results.passed = results.passed + structure_results.passed
  results.failed = results.failed + structure_results.failed
  for _, error in ipairs(structure_results.errors) do
    table.insert(results.errors, "structure: " .. error)
  end

  -- Test initialization
  local init_results = test_keymap_initialization()
  results.passed = results.passed + init_results.passed
  results.failed = results.failed + init_results.failed
  for _, error in ipairs(init_results.errors) do
    table.insert(results.errors, "initialization: " .. error)
  end

  -- Test core keymaps
  local core_results = test_core_keymaps_functionality()
  results.passed = results.passed + core_results.passed
  results.failed = results.failed + core_results.failed
  for _, error in ipairs(core_results.errors) do
    table.insert(results.errors, "core: " .. error)
  end

  -- Test editor keymaps
  local editor_results = test_editor_keymaps_functionality()
  results.passed = results.passed + editor_results.passed
  results.failed = results.failed + editor_results.failed
  for _, error in ipairs(editor_results.errors) do
    table.insert(results.errors, "editor: " .. error)
  end

  -- Test navigation keymaps
  local navigation_results = test_navigation_keymaps_functionality()
  results.passed = results.passed + navigation_results.passed
  results.failed = results.failed + navigation_results.failed
  for _, error in ipairs(navigation_results.errors) do
    table.insert(results.errors, "navigation: " .. error)
  end

  -- Test themes keymaps
  local themes_results = test_themes_keymaps_functionality()
  results.passed = results.passed + themes_results.passed
  results.failed = results.failed + themes_results.failed
  for _, error in ipairs(themes_results.errors) do
    table.insert(results.errors, "themes: " .. error)
  end

  -- Test which-key integration
  local wk_results = test_which_key_integration()
  results.passed = results.passed + wk_results.passed
  results.failed = results.failed + wk_results.failed
  for _, error in ipairs(wk_results.errors) do
    table.insert(results.errors, "which-key: " .. error)
  end

  -- Test plugin modules structure
  local plugin_structure_results = test_plugin_modules_structure()
  results.passed = results.passed + plugin_structure_results.passed
  results.failed = results.failed + plugin_structure_results.failed
  for _, error in ipairs(plugin_structure_results.errors) do
    table.insert(results.errors, "plugin_structure: " .. error)
  end

  -- Test plugin modules functionality
  local plugin_func_results = test_plugin_modules_functionality()
  results.passed = results.passed + plugin_func_results.passed
  results.failed = results.failed + plugin_func_results.failed
  for _, error in ipairs(plugin_func_results.errors) do
    table.insert(results.errors, "plugin_functionality: " .. error)
  end

  -- Test conditional loading
  local loading_results = test_conditional_loading()
  results.passed = results.passed + loading_results.passed
  results.failed = results.failed + loading_results.failed
  for _, error in ipairs(loading_results.errors) do
    table.insert(results.errors, "loading: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running keymap modernization tests...")
  print("=" .. string.rep("=", 40))
  
  local results = test_keymap_modernization()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 40))
  
  local success = results.failed == 0
  if success then
    print("🎉 Keymap modernization test PASSED!")
  else
    print("❌ Keymap modernization test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_keymap_module_structure = test_keymap_module_structure,
  test_keymap_initialization = test_keymap_initialization,
  test_core_keymaps_functionality = test_core_keymaps_functionality,
  test_editor_keymaps_functionality = test_editor_keymaps_functionality,
  test_navigation_keymaps_functionality = test_navigation_keymaps_functionality,
  test_themes_keymaps_functionality = test_themes_keymaps_functionality,
  test_which_key_integration = test_which_key_integration,
  test_plugin_modules_structure = test_plugin_modules_structure,
  test_plugin_modules_functionality = test_plugin_modules_functionality,
  test_conditional_loading = test_conditional_loading,
  test_keymap_modernization = test_keymap_modernization,
  run_tests = run_tests
}