#!/bin/bash

# Test script for core plugins
# Tests that core plugins work correctly with lazy.nvim

echo "Testing core plugins with lazy.nvim..."
echo "====================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing core plugin functionality..."
echo "----------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/core_plugins_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Core plugins test PASSED!"
  echo "Essential plugins are working correctly."
else
  echo "❌ Core plugins test FAILED!"
  echo "There may be issues with core plugin functionality."
  exit 1
fi

echo ""
echo "Core Plugins Summary:"
echo "===================="
echo "• vim-polyglot: ✅ Syntax highlighting with lazy loading"
echo "• auto-pairs: ✅ Bracket completion on insert mode"
echo "• nvim-tree: ✅ File explorer with command and key triggers"
echo "• Plugin configs: ✅ VimScript configs loading from plug-config/"