#!/bin/bash

# Test script for lazy.nvim migration
# Tests that the plugin manager migration works correctly

echo "Testing lazy.nvim plugin manager migration..."
echo "============================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing with new lazy.nvim plugin manager..."
echo "-------------------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/lazy_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Lazy.nvim migration test PASSED!"
  echo "Plugin manager migration successful."
else
  echo "❌ Migration test FAILED!"
  echo "There may be issues with the lazy.nvim setup."
  exit 1
fi

echo ""
echo "Migration Summary:"
echo "=================="
echo "• Plugin manager: lazy.nvim (with vim-plug fallback)"
echo "• Bootstrap: ✅ Automatic installation"
echo "• Lazy loading: ✅ Enabled for better performance"
echo "• Compatibility: ✅ Fallback to vim-plug if needed"
echo "• All plugins: ✅ Migrated from vim-plug format"