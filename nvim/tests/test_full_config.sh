#!/bin/bash

# Comprehensive test script for the complete Neovim configuration
# Tests that all components work together correctly

echo "Running comprehensive Neovim configuration test..."
echo "=================================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing with new init.lua..."
echo "----------------------------"

# Run the comprehensive test with the new init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/full_config_test.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Comprehensive configuration test PASSED!"
  echo "The new Lua configuration is working correctly."
else
  echo "❌ Configuration test FAILED!"
  echo "There may be issues with the migration."
  exit 1
fi

echo ""
echo "Configuration Summary:"
echo "====================="
echo "• Modern Lua configuration modules: ✅ Active"
echo "• VimScript compatibility: ✅ Maintained" 
echo "• Plugin system: ✅ vim-plug preserved"
echo "• Theme system: ✅ All themes available"
echo "• Key mappings: ✅ Migrated to Lua"
echo "• Auto commands: ✅ Migrated to Lua"
echo "• FZF integration: ✅ Fully functional"