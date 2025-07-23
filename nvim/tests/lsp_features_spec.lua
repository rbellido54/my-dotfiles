-- Tests for LSP feature functionality comparison
-- This test file verifies that LSP features work identically to vim-plug version

local function test_lsp_client_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if LSP client is available and functional
  if vim.lsp and vim.lsp.get_clients then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "LSP client not available or incomplete")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if LSP configuration functions exist
  if vim.lsp.buf then
    local lsp_functions = {
      "hover",
      "definition", 
      "references",
      "code_action",
      "rename",
      "format"
    }

    for _, func_name in ipairs(lsp_functions) do
      if type(vim.lsp.buf[func_name]) == "function" then
        results.passed = results.passed + 1
      else
        table.insert(results.errors, string.format("LSP function 'vim.lsp.buf.%s' not available", func_name))
        results.failed = results.failed + 1
      end
    end
  else
    table.insert(results.errors, "vim.lsp.buf namespace not available")
    results.failed = results.failed + 6
  end

  -- Test 3: Check if diagnostic functionality exists
  if vim.diagnostic and vim.diagnostic.get then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "LSP diagnostic functionality not available")
    results.failed = results.failed + 1
  end

  return results
end

local function test_formatting_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if conform.nvim is available
  local conform_ok, conform = pcall(require, "conform")
  if conform_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "conform.nvim not available: " .. tostring(conform))
    results.failed = results.failed + 1
  end

  -- Test 2: Check if format function exists
  if conform_ok and type(conform.format) == "function" then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "conform.format function not available")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if formatters are configured
  if conform_ok and conform.list_formatters then
    local formatters = conform.list_formatters()
    if type(formatters) == "table" then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "No formatters configured")
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot check formatter configuration")
    results.failed = results.failed + 1
  end

  return results
end

local function test_linting_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if nvim-lint is available
  local lint_ok, lint = pcall(require, "lint")
  if lint_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-lint not available: " .. tostring(lint))
    results.failed = results.failed + 1
  end

  -- Test 2: Check if lint function exists
  if lint_ok and type(lint.try_lint) == "function" then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "lint.try_lint function not available")
    results.failed = results.failed + 1
  end

  -- Test 3: Check if linters are configured
  if lint_ok and lint.linters_by_ft then
    local linters = lint.linters_by_ft
    if type(linters) == "table" and next(linters) ~= nil then
      results.passed = results.passed + 1
    else
      table.insert(results.errors, "No linters configured")
      results.failed = results.failed + 1
    end
  else
    table.insert(results.errors, "Cannot check linter configuration")
    results.failed = results.failed + 1
  end

  return results
end

local function test_copilot_functionality()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if Copilot is available
  if vim.g.copilot_enabled ~= nil or vim.fn.exists("*copilot#Accept") == 1 then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Copilot functionality not available")
    results.failed = results.failed + 1
  end

  -- Test 2: Check if CopilotChat is available
  local copilot_chat_ok = pcall(require, "CopilotChat")
  if copilot_chat_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "CopilotChat not available (may be lazy loaded)")
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

  return results
end

local function test_mason_integration()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test 1: Check if Mason is available
  local mason_ok, mason = pcall(require, "mason")
  if mason_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Mason not available: " .. tostring(mason))
    results.failed = results.failed + 1
  end

  -- Test 2: Check if Mason-LSPConfig is available
  local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
  if mason_lsp_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "Mason-LSPConfig not available: " .. tostring(mason_lsp))
    results.failed = results.failed + 1
  end

  -- Test 3: Check if LSPConfig is available
  local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
  if lspconfig_ok then
    results.passed = results.passed + 1
  else
    table.insert(results.errors, "nvim-lspconfig not available: " .. tostring(lspconfig))
    results.failed = results.failed + 1
  end

  return results
end

local function test_lsp_features()
  local results = {
    passed = 0,
    failed = 0,
    errors = {}
  }

  -- Test LSP client functionality
  local lsp_results = test_lsp_client_functionality()
  results.passed = results.passed + lsp_results.passed
  results.failed = results.failed + lsp_results.failed
  for _, error in ipairs(lsp_results.errors) do
    table.insert(results.errors, "lsp-client: " .. error)
  end

  -- Test formatting functionality
  local format_results = test_formatting_functionality()
  results.passed = results.passed + format_results.passed
  results.failed = results.failed + format_results.failed
  for _, error in ipairs(format_results.errors) do
    table.insert(results.errors, "formatting: " .. error)
  end

  -- Test linting functionality
  local lint_results = test_linting_functionality()
  results.passed = results.passed + lint_results.passed
  results.failed = results.failed + lint_results.failed
  for _, error in ipairs(lint_results.errors) do
    table.insert(results.errors, "linting: " .. error)
  end

  -- Test Copilot functionality
  local copilot_results = test_copilot_functionality()
  results.passed = results.passed + copilot_results.passed
  results.failed = results.failed + copilot_results.failed
  for _, error in ipairs(copilot_results.errors) do
    table.insert(results.errors, "copilot: " .. error)
  end

  -- Test Mason integration
  local mason_results = test_mason_integration()
  results.passed = results.passed + mason_results.passed
  results.failed = results.failed + mason_results.failed
  for _, error in ipairs(mason_results.errors) do
    table.insert(results.errors, "mason: " .. error)
  end

  return results
end

-- Main test runner
local function run_tests()
  print("Running LSP feature compatibility tests...")
  print("=" .. string.rep("=", 45))
  
  local results = test_lsp_features()
  
  print(string.format("Tests passed: %d", results.passed))
  print(string.format("Tests failed: %d", results.failed))
  
  if #results.errors > 0 then
    print("\nErrors:")
    for _, error in ipairs(results.errors) do
      print("  - " .. error)
    end
  end
  
  print("=" .. string.rep("=", 45))
  
  local success = results.failed == 0
  if success then
    print("🎉 LSP features test PASSED!")
  else
    print("❌ LSP features test FAILED!")
  end
  
  return success
end

-- Export for external use
return {
  test_lsp_client_functionality = test_lsp_client_functionality,
  test_formatting_functionality = test_formatting_functionality,
  test_linting_functionality = test_linting_functionality,
  test_copilot_functionality = test_copilot_functionality,
  test_mason_integration = test_mason_integration,
  test_lsp_features = test_lsp_features,
  run_tests = run_tests
}