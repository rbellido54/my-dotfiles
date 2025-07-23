#!/bin/bash

# Test script for init.lua loading sequence
# This tests that the new init.lua loads everything correctly

echo "Testing Neovim init.lua loading sequence..."
echo "=========================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

# Run the test in Neovim with the new init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/init_spec.lua').run_tests()" \
  -c "qa!"

exit_code=$?

if [ $exit_code -eq 0 ]; then
  echo "✓ All tests passed!"
else
  echo "✗ Some tests failed"
  exit 1
fi