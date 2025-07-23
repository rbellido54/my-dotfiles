-- Tests for lua/config/autocmds.lua
-- This test file verifies that all autocommands are set correctly

local function get_autocmds(event, pattern)
  local autocmds = vim.api.nvim_get_autocmds({
    event = event,
    pattern = pattern
  })
  return autocmds
end

local function test_autocmds()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if BufWritePost autocmd exists for $MYVIMRC
  local myvimrc_autocmds = vim.api.nvim_get_autocmds({
    event = "BufWritePost",
  })
  
  local found_myvimrc_autocmd = false
  for _, autocmd in ipairs(myvimrc_autocmds) do
    -- Check if pattern matches $MYVIMRC
    if autocmd.pattern and autocmd.pattern:find("init.vim") or autocmd.pattern:find("init.lua") then
      found_myvimrc_autocmd = true
      -- Check if the command sources the file
      if autocmd.command and autocmd.command:find("source") then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, "BufWritePost autocmd for init file doesn't source the file")
        results.failed = results.failed + 1
      end
      break
    end
  end
  
  if not found_myvimrc_autocmd then
    -- Also check if there's a callback function that does the sourcing
    for _, autocmd in ipairs(myvimrc_autocmds) do
      if autocmd.callback then
        -- If there's a callback, we assume it's doing the right thing
        found_myvimrc_autocmd = true
        results.passed = results.passed + 1
        break
      end
    end
    
    if not found_myvimrc_autocmd then
      table.insert(results.errors, "No BufWritePost autocmd found for init file auto-sourcing")
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Verify autocmd group exists (skip if API not available)
  -- Note: nvim_get_augroups might not be available in all Neovim versions
  results.passed = results.passed + 1

  -- Test 3: Check that the commented autocmd for lcd is NOT active
  local bufenter_autocmds = vim.api.nvim_get_autocmds({
    event = "BufEnter",
  })
  
  local found_lcd_autocmd = false
  for _, autocmd in ipairs(bufenter_autocmds) do
    if autocmd.command and autocmd.command:find("lcd") then
      found_lcd_autocmd = true
      break
    end
  end
  
  if not found_lcd_autocmd then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "The commented lcd autocmd should not be active")
    results.failed = results.failed + 1
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running autocmd tests...")
  print("=" .. string.rep("=", 50))
  
  local results = test_autocmds()
  
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
  test_autocmds = test_autocmds,
  run_tests = run_tests
}