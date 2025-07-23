-- Test runner for Neovim configuration tests
-- This can be run with: nvim -l nvim/tests/run_tests.lua

-- Add the nvim directory to the runtime path
vim.opt.runtimepath:prepend(vim.fn.getcwd() .. "/nvim")

local test_files = {
  "options_spec",
}

local total_passed = 0
local total_failed = 0
local failed_tests = {}

print("Neovim Configuration Test Suite")
print("================================\n")

-- Run each test file
for _, test_file in ipairs(test_files) do
  local ok, test_module = pcall(require, "tests." .. test_file)
  
  if ok and test_module.run_tests then
    print("\nRunning " .. test_file .. "...")
    local success = test_module.run_tests()
    
    if not success then
      table.insert(failed_tests, test_file)
    end
  else
    print("Failed to load test file: " .. test_file)
    if not ok then
      print("Error: " .. tostring(test_module))
    end
    table.insert(failed_tests, test_file)
  end
end

print("\n\nTest Summary")
print("============")

if #failed_tests == 0 then
  print("All tests passed! ✓")
  os.exit(0)
else
  print("Failed tests:")
  for _, test in ipairs(failed_tests) do
    print("  - " .. test)
  end
  os.exit(1)
end