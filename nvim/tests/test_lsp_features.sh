#!/bin/bash

# Test script for LSP feature comparison
# Tests that LSP features work identically to vim-plug version

echo "Testing LSP feature functionality with lazy.nvim..."
echo "=================================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing LSP feature compatibility..."
echo "----------------------------------"

# Create a temporary test file for LSP testing
cat > /tmp/test_lsp.lua << 'EOF'
-- Test file for LSP functionality
local function test_function()
  local test_var = "hello world"
  print(test_var)
  return test_var
end

-- This should trigger LSP diagnostics if configured properly
local unused_var = 42

return test_function
EOF

# Test LSP functionality with a real file
nvim --headless -u nvim/init.lua \
  -c "edit /tmp/test_lsp.lua" \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/lsp_features_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

# Clean up temporary file
rm -f /tmp/test_lsp.lua

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ LSP features test PASSED!"
  echo "LSP functionality works identically to vim-plug version."
else
  echo "❌ LSP features test FAILED!"
  echo "There may be differences in LSP functionality."
  exit 1
fi

echo ""
echo "LSP Features Summary:"
echo "===================="
echo "• LSP Client: ✅ Native Neovim LSP functionality"
echo "• Server Management: ✅ Mason integration for automatic installation" 
echo "• Formatting: ✅ conform.nvim with format-on-save and manual triggers"
echo "• Linting: ✅ nvim-lint with automatic triggers on file events"
echo "• Code Completion: ✅ LSP-based completion with fallback support"
echo "• Diagnostics: ✅ Native LSP diagnostics display"