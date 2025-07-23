-- Tests for navigation and git integration functionality
-- This test file verifies that fuzzy finding, git integration, and navigation plugins work correctly with lazy.nvim

local function test_fuzzy_finding()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- List of FZF-related plugins
  local fzf_plugins = {
    "fzf",
    "fzf.vim"
  }

  -- Test 1: Check if FZF plugins are installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  for _, plugin in ipairs(fzf_plugins) do
    local plugin_path = lazy_path .. "/" .. plugin
    if vim.fn.isdirectory(plugin_path) == 1 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("FZF plugin '%s' not found at %s", plugin, plugin_path))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check if FZF commands exist
  local fzf_commands = { "Files", "Buffers", "Rg" }
  for _, cmd in ipairs(fzf_commands) do
    if vim.fn.exists(":" .. cmd) == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("FZF command ':%s' not available", cmd))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if vim-rooter is installed
  local rooter_path = lazy_path .. "/vim-rooter"
  if vim.fn.isdirectory(rooter_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-rooter plugin not found")
    results.failed = results.failed + 1
  end

  return results
end

local function test_navigation_plugins()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if vim-sneak is installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  local sneak_path = lazy_path .. "/vim-sneak"
  if vim.fn.isdirectory(sneak_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-sneak plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if targets.vim is installed
  local targets_path = lazy_path .. "/targets.vim"
  if vim.fn.isdirectory(targets_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "targets.vim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if vim-bufkill is installed
  local bufkill_path = lazy_path .. "/vim-bufkill"
  if vim.fn.isdirectory(bufkill_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-bufkill plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 4: Check if BD command exists (from vim-bufkill)
  if vim.fn.exists(":BD") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":BD command not available")
    results.failed = results.failed + 1
  end

  -- Test 5: Check if vim-floaterm is installed
  local floaterm_path = lazy_path .. "/vim-floaterm"
  if vim.fn.isdirectory(floaterm_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-floaterm plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 6: Check if FloatermToggle command exists
  if vim.fn.exists(":FloatermToggle") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":FloatermToggle command not available")
    results.failed = results.failed + 1
  end

  return results
end

local function test_git_integration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- List of git-related plugins
  local git_plugins = {
    "vim-signify",
    "vim-fugitive", 
    "vim-rhubarb",
    "gv.vim",
    "lazygit.nvim"
  }

  -- Test 1: Check if git plugins are installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  for _, plugin in ipairs(git_plugins) do
    local plugin_path = lazy_path .. "/" .. plugin
    if vim.fn.isdirectory(plugin_path) == 1 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Git plugin '%s' not found at %s", plugin, plugin_path))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check if Git commands exist (from fugitive)
  local git_commands = { "Git", "Gstatus", "Gblame" }
  for _, cmd in ipairs(git_commands) do
    if vim.fn.exists(":" .. cmd) == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Git command ':%s' not available", cmd))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check if LazyGit command exists
  if vim.fn.exists(":LazyGit") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":LazyGit command not available")
    results.failed = results.failed + 1
  end

  -- Test 4: Check if GV command exists (from gv.vim)
  if vim.fn.exists(":GV") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":GV command not available")
    results.failed = results.failed + 1
  end

  -- Test 5: Check if GBrowse command exists (from vim-rhubarb)
  if vim.fn.exists(":GBrowse") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":GBrowse command not available")
    results.failed = results.failed + 1
  end

  return results
end

local function test_text_objects()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if vim-textobj-user is installed (dependency)
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  local textobj_user_path = lazy_path .. "/vim-textobj-user"
  if vim.fn.isdirectory(textobj_user_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-textobj-user plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if vim-textobj-ruby is installed
  local textobj_ruby_path = lazy_path .. "/vim-textobj-ruby"
  if vim.fn.isdirectory(textobj_ruby_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-textobj-ruby plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if vim-surround is installed
  local surround_path = lazy_path .. "/vim-surround"
  if vim.fn.isdirectory(surround_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-surround plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 4: Check if vim-repeat is installed
  local repeat_path = lazy_path .. "/vim-repeat"
  if vim.fn.isdirectory(repeat_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-repeat plugin not found")
    results.failed = results.failed + 1
  end

  return results
end

local function test_additional_tools()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if vim-commentary is installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  local commentary_path = lazy_path .. "/vim-commentary"
  if vim.fn.isdirectory(commentary_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-commentary plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if quick-scope is installed
  local quickscope_path = lazy_path .. "/quick-scope"
  if vim.fn.isdirectory(quickscope_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "quick-scope plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if vim-startify is installed
  local startify_path = lazy_path .. "/vim-startify"
  if vim.fn.isdirectory(startify_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "vim-startify plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 4: Check if goyo.vim is installed
  local goyo_path = lazy_path .. "/goyo.vim"
  if vim.fn.isdirectory(goyo_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "goyo.vim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 5: Check if Goyo command exists
  if vim.fn.exists(":Goyo") == 2 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, ":Goyo command not available")
    results.failed = results.failed + 1
  end

  return results
end

local function test_navigation_git_integration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test fuzzy finding
  local fzf_results = test_fuzzy_finding()
  results.passed = results.passed + fzf_results.passed
  results.failed = results.failed + fzf_results.failed
  for _, error in ipairs(fzf_results.errors) do
    table.insert(results.errors, "fzf: " .. error)
  end

  -- Test navigation plugins
  local nav_results = test_navigation_plugins()
  results.passed = results.passed + nav_results.passed
  results.failed = results.failed + nav_results.failed
  for _, error in ipairs(nav_results.errors) do
    table.insert(results.errors, "navigation: " .. error)
  end

  -- Test git integration
  local git_results = test_git_integration()
  results.passed = results.passed + git_results.passed
  results.failed = results.failed + git_results.failed
  for _, error in ipairs(git_results.errors) do
    table.insert(results.errors, "git: " .. error)
  end

  -- Test text objects
  local textobj_results = test_text_objects()
  results.passed = results.passed + textobj_results.passed
  results.failed = results.failed + textobj_results.failed
  for _, error in ipairs(textobj_results.errors) do
    table.insert(results.errors, "textobj: " .. error)
  end

  -- Test additional tools
  local tools_results = test_additional_tools()
  results.passed = results.passed + tools_results.passed
  results.failed = results.failed + tools_results.failed
  for _, error in ipairs(tools_results.errors) do
    table.insert(results.errors, "tools: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running navigation and git integration functionality tests...")
  print("=" .. string.rep("=", 65))
  
  local results = test_navigation_git_integration()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 65))
  
  local success = results.failed == 0
  if success then
    print("🎉 Navigation and git integration test PASSED!")
  else
    print("❌ Navigation and git integration test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_fuzzy_finding = test_fuzzy_finding,
  test_navigation_plugins = test_navigation_plugins,
  test_git_integration = test_git_integration,
  test_text_objects = test_text_objects,
  test_additional_tools = test_additional_tools,
  test_navigation_git_integration = test_navigation_git_integration,
  run_tests = run_tests
}