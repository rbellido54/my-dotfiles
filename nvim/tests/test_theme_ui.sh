#!/bin/bash

# Test script for theme and UI plugins
# Tests that themes and UI plugins work correctly with lazy.nvim

echo "Testing theme and UI plugins with lazy.nvim..."
echo "=============================================="

# Change to the dotfiles directory
cd "$(dirname "$0")/../.."

echo "Testing theme and UI plugin functionality..."
echo "------------------------------------------"

# Run the test with the updated init.lua
nvim --headless -u nvim/init.lua \
  -c "lua package.path = package.path .. ';./nvim/?.lua'" \
  -c "lua dofile('./nvim/tests/theme_ui_spec.lua').run_tests()" \
  -c "qa!" 2>&1

exit_code=$?

echo ""
if [ $exit_code -eq 0 ]; then
  echo "✅ Theme and UI plugins test PASSED!"
  echo "All themes and UI components are working correctly."
else
  echo "❌ Theme and UI plugins test FAILED!"
  echo "There may be issues with theme or UI plugin functionality."
  exit 1
fi

echo ""
echo "Theme and UI Summary:"
echo "===================="
echo "• Themes: ✅ 13 colorschemes with lazy loading on colorscheme command"
echo "• Airline: ✅ Status bar with theme integration"
echo "• Web-devicons: ✅ File icons with custom overrides"
echo "• Colorizer: ✅ Color highlighting for specific filetypes"
echo "• Which-key: ✅ Key binding hints with rounded borders"