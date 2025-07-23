-- Tests for LSP functionality, formatting, and linting
-- This test file verifies that LSP and development tools work correctly with lazy.nvim

local function test_mason_ecosystem()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- List of Mason ecosystem plugins
  local mason_plugins = {
    "mason.nvim",
    "mason-lspconfig.nvim",
    "nvim-lspconfig"
  }

  -- Test 1: Check if Mason ecosystem plugins are installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy"
  for _, plugin in ipairs(mason_plugins) do
    local plugin_path = lazy_path .. "/" .. plugin
    if vim.fn.isdirectory(plugin_path) == 1 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Mason plugin '%s' not found at %s", plugin, plugin_path))
      results.failed = results.failed + 1
    end
  end

  -- Test 2: Check if Mason commands exist
  local mason_commands = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" }
  for _, cmd in ipairs(mason_commands) do
    if vim.fn.exists(":" .. cmd) == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Mason command ':%s' not available", cmd))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Try to require mason modules
  local mason_modules = { "mason", "mason-lspconfig", "lspconfig" }
  for _, module in ipairs(mason_modules) do
    local ok = pcall(require, module)
    if ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Cannot require '%s' (may be lazy loaded)", module))
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_formatting_linting()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if conform.nvim is installed
  local conform_path = vim.fn.stdpath("data") .. "/lazy/conform.nvim"
  if vim.fn.isdirectory(conform_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "conform.nvim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if nvim-lint is installed  
  local lint_path = vim.fn.stdpath("data") .. "/lazy/nvim-lint"
  if vim.fn.isdirectory(lint_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-lint plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 3: Try to require formatting and linting modules
  local modules = { "conform", "lint" }
  for _, module in ipairs(modules) do
    local ok = pcall(require, module)
    if ok then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("Cannot require '%s' (may be lazy loaded)", module))
      results.failed = results.failed + 1
    end
  end

  return results
end

local function test_copilot_plugins()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if GitHub Copilot is installed
  local copilot_path = vim.fn.stdpath("data") .. "/lazy/copilot.vim"
  if vim.fn.isdirectory(copilot_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "copilot.vim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if CopilotChat is installed
  local copilot_chat_path = vim.fn.stdpath("data") .. "/lazy/CopilotChat.nvim"
  if vim.fn.isdirectory(copilot_chat_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "CopilotChat.nvim plugin not found")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if CopilotChat commands exist
  local copilot_commands = { "CopilotChat", "CopilotChatToggle" }
  for _, cmd in ipairs(copilot_commands) do
    if vim.fn.exists(":" .. cmd) == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("CopilotChat command ':%s' not available", cmd))
      results.failed = results.failed + 1
    end
  end

  -- Test 4: Check if plenary.nvim dependency is available
  local plenary_path = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
  if vim.fn.isdirectory(plenary_path) == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "plenary.nvim dependency not found")
    results.failed = results.failed + 1
  end

  return results
end

local function test_lsp_integration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if LSP client is available
  if vim.lsp then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "LSP client not available")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if LSP commands exist
  local lsp_commands = { "LspInfo", "LspLog", "LspRestart" }
  for _, cmd in ipairs(lsp_commands) do
    if vim.fn.exists(":" .. cmd) == 2 then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, string.format("LSP command ':%s' not available", cmd))
      results.failed = results.failed + 1
    end
  end

  -- Test 3: Check basic LSP configuration
  local lsp_config = vim.lsp.get_clients()
  if type(lsp_config) == "table" then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "LSP client configuration not accessible")
    results.failed = results.failed + 1
  end

  return results
end

local function test_lsp_dev_tools()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test Mason ecosystem
  local mason_results = test_mason_ecosystem()
  results.passed = results.passed + mason_results.passed
  results.failed = results.failed + mason_results.failed
  for _, error in ipairs(mason_results.errors) do
    table.insert(results.errors, "mason: " .. error)
  end

  -- Test formatting and linting
  local format_lint_results = test_formatting_linting()
  results.passed = results.passed + format_lint_results.passed
  results.failed = results.failed + format_lint_results.failed
  for _, error in ipairs(format_lint_results.errors) do
    table.insert(results.errors, "format/lint: " .. error)
  end

  -- Test Copilot plugins
  local copilot_results = test_copilot_plugins()
  results.passed = results.passed + copilot_results.passed
  results.failed = results.failed + copilot_results.failed
  for _, error in ipairs(copilot_results.errors) do
    table.insert(results.errors, "copilot: " .. error)
  end

  -- Test LSP integration
  local lsp_results = test_lsp_integration()
  results.passed = results.passed + lsp_results.passed
  results.failed = results.failed + lsp_results.failed
  for _, error in ipairs(lsp_results.errors) do
    table.insert(results.errors, "lsp: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running LSP and development tools functionality tests...")
  print("=" .. string.rep("=", 58))
  
  local results = test_lsp_dev_tools()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 58))
  
  local success = results.failed == 0
  if success then
    print("🎉 LSP and development tools test PASSED!")
  else
    print("❌ LSP and development tools test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_mason_ecosystem = test_mason_ecosystem,
  test_formatting_linting = test_formatting_linting,
  test_copilot_plugins = test_copilot_plugins,
  test_lsp_integration = test_lsp_integration,
  test_lsp_dev_tools = test_lsp_dev_tools,
  run_tests = run_tests
}