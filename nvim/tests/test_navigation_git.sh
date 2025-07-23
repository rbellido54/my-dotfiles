#!/bin/bash

# Test script for navigation and git integration
# Tests that fuzzy finding, git integration, and navigation plugins work correctly with lazy.nvim

echo "Testing navigation and git integration with lazy.nvim..."
echo "====================================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing navigation and git integration functionality..."
echo "---------------------------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/navigation_git_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Navigation and git integration test PASSED!"
  echo "All navigation and git tools are working correctly."
else
  echo "❌ Navigation and git integration test FAILED!"
  echo "There may be issues with navigation or git functionality."
  exit 1
fi

echo ""
echo "Navigation and Git Integration Summary:"
echo "======================================"
echo "• FZF: ✅ Fuzzy finder with file, buffer, and live grep commands"
echo "• vim-rooter: ✅ Automatic project root detection"
echo "• vim-sneak: ✅ Enhanced character-based motion"
echo "• Text Objects: ✅ Additional text objects with targets.vim"
echo "• Git Integration: ✅ fugitive, signify, lazygit, and gv.vim"
echo "• Navigation: ✅ Buffer management with vim-bufkill"
echo "• Terminal: ✅ Floating terminal with floaterm"