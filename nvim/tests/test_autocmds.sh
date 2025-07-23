#!/bin/bash

# Test script for autocmds module
# This tests that autocmds are set correctly when config is loaded

echo "Testing Neovim autocmds configuration..."
echo "======================================"

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

# Run the test in Neovim
nvim --headless -u NONE \
  -c "set runtimepath+=$PWD/nvim" \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua require('config')" \
  -c "lua dofile('./nvim/tests/autocmds_spec.lua').run_tests()" \
  -c "qa!"

exit_code=$?

if [ $exit_code -eq 0 ]; then
  echo "✓ All tests passed!"
else
  echo "✗ Some tests failed"
  exit 1
fi