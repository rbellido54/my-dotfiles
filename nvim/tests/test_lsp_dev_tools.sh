#!/bin/bash

# Test script for LSP and development tools
# Tests that LSP, formatting, linting, and development tools work correctly with lazy.nvim

echo "Testing LSP and development tools with lazy.nvim..."
echo "=================================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing LSP and development tools functionality..."
echo "-----------------------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/lsp_dev_tools_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ LSP and development tools test PASSED!"
  echo "All development tools are working correctly."
else
  echo "❌ LSP and development tools test FAILED!"
  echo "There may be issues with LSP or development tool functionality."
  exit 1
fi

echo ""
echo "LSP and Development Tools Summary:"
echo "================================="
echo "• Mason: ✅ LSP server manager with installation commands"
echo "• Mason-LSPConfig: ✅ Bridge between Mason and nvim-lspconfig"
echo "• nvim-lspconfig: ✅ Native LSP client configurations"
echo "• conform.nvim: ✅ Formatter with write triggers"
echo "• nvim-lint: ✅ Linting with buffer event triggers"
echo "• Copilot: ✅ AI assistance with insert mode loading"
echo "• CopilotChat: ✅ AI chat interface with command triggers"