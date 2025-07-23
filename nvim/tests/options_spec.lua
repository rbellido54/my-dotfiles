-- Tests for lua/config/options.lua
-- This test file verifies that all vim options are set correctly

local function capture_option(option_name)
  local ok, value = pcall(function()
    return vim.api.nvim_get_option_value(option_name, {})
  end)
  if ok then
    return value
  else
    return nil
  end
end

local function test_options()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Expected option values based on general/settings.vim
  local expected_options = {
    -- Display options
    wrap = false,
    pumheight = 10,
    ruler = true,
    cmdheight = 2,
    conceallevel = 0,
    showtabline = 2,
    showmode = false,
    laststatus = 0,
    number = true,
    relativenumber = true,
    cursorline = true,
    background = "dark",
    
    -- Encoding
    encoding = "utf-8",
    fileencoding = "utf-8",
    
    -- Indentation
    tabstop = 2,
    shiftwidth = 2,
    smarttab = true,
    expandtab = true,
    smartindent = true,
    autoindent = true,
    
    -- Behavior
    hidden = true,
    mouse = "a",
    splitbelow = true,
    splitright = true,
    backup = false,
    writebackup = false,
    swapfile = false,
    updatetime = 300,
    timeoutlen = 500,
    clipboard = "unnamedplus",
    
    -- Other
    -- iskeyword is handled separately since it's appended to
    formatoptions = "cro",
  }

  -- Test global variables
  local expected_globals = {
    mapleader = " "
  }

  -- Test each option
  for option, expected_value in pairs(expected_options) do
    local actual_value = capture_option(option)
    
    if actual_value == nil then
      table.insert(results.errors, string.format("Option '%s' could not be read", option))
      results.failed = results.failed + 1
    elseif actual_value == expected_value then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format(
        "Option '%s': expected %s, got %s",
        option,
        vim.inspect(expected_value),
        vim.inspect(actual_value)
      ))
      results.failed = results.failed + 1
    end
  end

  -- Test global variables
  for var, expected_value in pairs(expected_globals) do
    local actual_value = vim.g[var]
    if actual_value == expected_value then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format(
        "Global '%s': expected %s, got %s",
        var,
        vim.inspect(expected_value),
        vim.inspect(actual_value)
      ))
      results.failed = results.failed + 1
    end
  end

  -- Note: t_Co is not supported in Neovim, so we skip this test
  
  -- Test iskeyword contains '-'
  local iskeyword = vim.opt.iskeyword:get()
  local has_dash = false
  for _, value in ipairs(iskeyword) do
    if value == "-" then
      has_dash = true
      break
    end
  end
  
  if has_dash then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "iskeyword does not contain '-'")
    results.failed = results.failed + 1
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running options tests...")
  print("=" .. string.rep("=", 50))
  
  local results = test_options()
  
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
  test_options = test_options,
  run_tests = run_tests
}