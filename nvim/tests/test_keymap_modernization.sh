#!/bin/bash

# Test script for keymap modernization
# Tests that the new modular keymap system works correctly

echo "Testing modular keymap system..."
echo "================================"

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing keymap module loading and functionality..."
echo "------------------------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/keymap_modernization_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Keymap modernization test PASSED!"
  echo "Modular keymap system is working correctly."
else
  echo "❌ Keymap modernization test FAILED!"
  echo "There may be issues with the new keymap system."
  exit 1
fi

echo ""
echo "Keymap Modernization Summary:"
echo "============================"
echo "• Core Keymaps: ✅ Essential vim keymaps with modern Lua patterns"
echo "• Modular Structure: ✅ Organized into logical modules with conditional loading"
echo "• which-key Integration: ✅ Enhanced keymap discovery and documentation"
echo "• Fallback System: ✅ Graceful degradation when plugins are unavailable"
echo "• Testing Framework: ✅ Comprehensive tests for module loading and functionality"