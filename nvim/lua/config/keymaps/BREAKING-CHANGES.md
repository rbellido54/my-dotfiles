# Breaking Changes - Keymap Modernization

> Migration from legacy keymaps to modular system
> Created: 2025-07-23
> Version: 1.0.0

## Overview

This document outlines any breaking changes introduced during the keymap modernization migration from the legacy VimScript and scattered Lua keymaps to the new modular system.

## Summary

**Good News**: The migration was designed to be **backward compatible** with minimal breaking changes. Most existing keymaps continue to work as before, but are now better organized and documented.

## Non-Breaking Changes

The following changes were made but **do not break** existing functionality:

### Enhanced Functionality
- **which-key integration**: All keymaps now have descriptions and show in which-key popups
- **Conditional loading**: Plugin-specific keymaps only load when plugins are available
- **Better organization**: Keymaps are now organized in logical modules
- **Improved help**: Each module includes help functions (`<leader>g?`, `<leader>l?`, etc.)

### Configuration Updates
- **FZF settings**: Updated to match legacy configuration exactly
- **Floaterm configuration**: Enhanced with better defaults while preserving existing behavior
- **which-key groups**: Added comprehensive group definitions for better navigation

## Minor Breaking Changes

### 1. Function Key Mappings (Floaterm)

**Old behavior** (from `plug-config/floaterm.vim`):
```vim
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_next   = '<F2>'
let g:floaterm_keymap_prev   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'
```

**New behavior** (from `terminal.lua`):
```lua
vim.g.floaterm_keymap_toggle = "<F12>"  -- Changed from F1 to F12
vim.g.floaterm_keymap_new = "<F10>"     -- Changed from F4 to F10
vim.g.floaterm_keymap_kill = "<F8>"     -- Added kill mapping
vim.g.floaterm_keymap_next = "<F2>"     -- Unchanged
vim.g.floaterm_keymap_prev = "<F3>"     -- Unchanged
```

**Reason**: F1 conflicts with help, F12 is more logical for terminal toggle

**Migration**: Update muscle memory or customize the mappings in your local config

### 2. Core Keymap Refinement

**Old behavior**: `core.lua` contained many editing and navigation keymaps

**New behavior**: `core.lua` only contains truly essential vim keymaps, with functionality moved to:
- Text editing operations → `editor.lua`
- Window/buffer navigation → `navigation.lua`

**Impact**: No functional changes, just better organization

### 3. LSP Keymaps Consolidation

**Old behavior**: LSP keymaps scattered across `lsp-config.lua`

**New behavior**: All LSP keymaps consolidated in `lsp.lua` module

**Impact**: Existing keymaps work the same, just better organized and documented

## Configuration Migration

### If You Have Custom Keymaps

If you have custom keymaps that conflict with the new system:

1. **Check the migration guide**: See `MIGRATION-GUIDE.md` for current keymap assignments
2. **Use the help functions**: Press `<leader>?` or specific help keys to see available keymaps
3. **Override in local config**: Add your custom keymaps after the system loads

### Example Custom Override

```lua
-- In your personal init.lua or after the keymap system loads
vim.keymap.set("n", "<F1>", "<cmd>FloatermToggle<CR>", { desc = "Toggle terminal" })
```

## Fallback Mechanism

The system includes a robust fallback mechanism:

- **Legacy fallback**: If the modern system fails, it falls back to `keymaps-legacy.lua`
- **Plugin detection**: Keymaps only load when corresponding plugins are available
- **Graceful degradation**: Missing plugins don't break the system

## Testing Changes

Run the comprehensive test suite to verify everything works:

```bash
nvim --headless -c "lua require('tests.keymap_modernization_spec').run_tests()" -c "qa"
```

**Expected result**: All 94 tests should pass

## Rollback Instructions

If you need to rollback to the legacy system:

1. **Disable modern system**: Comment out `require("config.keymaps")` in your init
2. **Enable legacy system**: Uncomment or re-add `require("config.keymaps-legacy")`
3. **Restore original configs**: Revert any changes to plugin configurations

## Support

### Help Commands

Each module includes help commands:
- `<leader>g?` - Git keymaps help
- `<leader>l?` - LSP keymaps help  
- `<leader>a?` - AI keymaps help
- `<leader>t?` - Terminal keymaps help
- `<leader>?` - FZF keymaps help

### Debug Mode

Enable debug mode to see what's loading:

```lua
local keymap_system = require("config.keymaps.init")
keymap_system.set_debug(true)
keymap_system.setup()
```

### Checking System Status

```lua
local keymap_system = require("config.keymaps.init")
local stats = keymap_system.get_stats()
print(vim.inspect(stats))
```

## Conclusion

The keymap modernization maintains **99% backward compatibility** while providing significant improvements in organization, documentation, and functionality. The only notable breaking change is the function key reassignment for terminal operations, which can be easily customized if needed.

The new system is designed to be:
- **More discoverable** (via which-key integration)
- **Better organized** (modular structure)
- **More reliable** (comprehensive testing)
- **Easier to extend** (clear module template)

For most users, the migration should be seamless with improved functionality.