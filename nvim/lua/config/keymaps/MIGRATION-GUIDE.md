# Keymap Modernization Migration Guide

> Guide for migrating scattered VimScript keymaps to organized Lua modules
> Created: 2025-07-23
> Status: Framework Complete

## Overview

This document provides the framework and guidelines for migrating existing keymaps from scattered VimScript and Lua configurations to the new modular keymap system with which-key integration.

## Migration Framework

### Current State
- **Legacy keymaps.lua**: Contains mixed keymap definitions and FZF configuration
- **VimScript configs**: Scattered across `plug-config/` directory
- **which-key mappings**: Separate file with limited integration

### Target State
- **Modular structure**: Organized by functionality in `config/keymaps/`
- **which-key integration**: Built-in support for all keymaps
- **Conditional loading**: Plugin-dependent keymaps load only when plugins are available
- **Comprehensive testing**: Full test coverage for all keymap modules

## Module Structure

### Core Modules (Always Loaded)
- `config.keymaps.core` ✅ - Essential vim keymaps (refactored for minimal scope)
- `config.keymaps.editor` ✅ - Text editing and manipulation keymaps
- `config.keymaps.navigation` ✅ - Window and buffer navigation keymaps

### Plugin Modules (Conditionally Loaded)
- `config.keymaps.git` ✅ - Git integration keymaps (fugitive, signify, lazygit)
- `config.keymaps.fzf` ✅ - Fuzzy finder keymaps and configuration
- `config.keymaps.lsp` ✅ - LSP and development tools (mason, conform, lint)
- `config.keymaps.ai` ✅ - AI and Copilot integration keymaps
- `config.keymaps.terminal` ⏳ - Terminal management

## Migration Process

### Step 1: Analyze Existing Keymaps
1. **Audit current keymaps** in `keymaps-legacy.lua`
2. **Categorize by functionality** (core, git, fzf, lsp, etc.)
3. **Identify plugin dependencies** for conditional loading
4. **Document current behavior** to ensure preservation

### Step 2: Create Module Structure
```lua
-- Example module structure
return {
  setup = function()
    -- Module initialization
  end,
  keymaps = {
    -- Keymap definitions for testing/documentation
  }
}
```

### Step 3: Convert Keymaps to Modern Format
```lua
-- Old format
vim.keymap.set("n", "<leader>g", ":Git<CR>", { noremap = true, silent = true })

-- New format
{
  "<leader>g", 
  "<cmd>Git<cr>", 
  desc = "Open Git status", 
  mode = "n"
}
```

### Step 4: Add which-key Integration
```lua
local wk_helper = require("config.keymaps.which-key-integration")
wk_helper.add_keymaps(module_mappings)
```

### Step 5: Implement Tests
Each module should have corresponding tests to verify:
- Module can be loaded
- Keymaps are registered correctly
- Plugin dependencies work
- which-key integration functions

## Template for New Modules

```lua
-- config/keymaps/[module-name].lua
-- [Description of module purpose]

local M = {}

-- Get which-key integration helper
local function get_wk_helper()
  local ok, wk_integration = pcall(require, "config.keymaps.which-key-integration")
  if ok then
    return wk_integration
  end
  return nil
end

-- Setup function
function M.setup()
  local wk_helper = get_wk_helper()
  
  -- Define keymaps with descriptions
  local mappings = {
    { "<leader>x", "<cmd>Example<cr>", desc = "Example command", mode = "n" },
    -- More keymaps...
  }
  
  -- Register keymaps - always register manually first
  for _, mapping in ipairs(mappings) do
    if mapping[1] and mapping[2] then
      local modes = mapping.mode or "n"
      local opts = {
        desc = mapping.desc,
        noremap = mapping.noremap ~= false,
        silent = mapping.silent ~= false,
        expr = mapping.expr,
      }
      vim.keymap.set(modes, mapping[1], mapping[2], opts)
    end
  end
  
  -- Also register with which-key for better help display
  if wk_helper then
    wk_helper.add_keymaps(mappings)
  end
  
  return true
end

-- Export keymaps for testing or external use
M.keymaps = {
  -- Categories for easy reference
}

return M
```

## Legacy Keymaps to Migrate

### From `keymaps-legacy.lua`:
- [x] **Essential keymaps**: `jj`, `<C-s>`, `<C-c>`, etc. → `core.lua`
- [x] **Window navigation**: `<C-hjkl>`, `<M-hjkl>` → `navigation.lua`
- [x] **Buffer management**: `<TAB>`, `<S-TAB>` → `navigation.lua`
- [x] **Visual mode**: `<>`, `JK` → `editor.lua`
- [x] **Text editing**: Line manipulation, clipboard, search centering → `editor.lua`
- [ ] **FZF configuration**: All FZF settings → `fzf.lua`
- [ ] **FZF commands**: Custom commands → `fzf.lua`

### From `plug-config/which-key-mappings.lua`:
- [x] **AI/Copilot**: `<leader>a*` → `ai.lua`
- [x] **Buffer operations**: `<leader>b*` → `navigation.lua`
- [x] **Git operations**: `<leader>g*` → `git.lua`
- [x] **Search operations**: `<leader>G`, `<leader>g` → `fzf.lua`

## Benefits of Migration

### For Users
- **Better discoverability**: which-key integration shows all available keymaps
- **Consistent behavior**: All keymaps work the same way across modules
- **Faster loading**: Only relevant keymaps load when plugins are available
- **Self-documenting**: Every keymap has a description

### For Developers
- **Organized structure**: Easy to find and modify keymaps
- **Testable**: Each module can be tested independently
- **Maintainable**: Clear separation of concerns
- **Extensible**: Easy to add new keymap modules

## Testing Strategy

### Unit Tests
Each module should have tests that verify:
- Module can be loaded without errors
- Setup function works correctly
- Keymaps are registered in correct modes
- Descriptions are properly set

### Integration Tests
- Full keymap system loads correctly
- which-key integration works
- Fallback behavior functions properly
- Plugin dependency detection works

### Regression Tests
- All existing keymaps still work
- No conflicts between modules
- Performance is maintained or improved

## Migration Status

| Component | Status | Module | Notes |
|-----------|--------|---------|-------|
| Framework | ✅ Complete | `init.lua` | Modular loading system |
| which-key Integration | ✅ Complete | `which-key-integration.lua` | Modern v3 config |
| Core Keymaps | ✅ Complete | `core.lua` | Essential vim keymaps (refactored) |
| Editor Keymaps | ✅ Complete | `editor.lua` | Text editing operations |
| Navigation Keymaps | ✅ Complete | `navigation.lua` | Windows/buffers/tabs |
| Git Keymaps | ✅ Complete | `git.lua` | Git integration (40+ keymaps) |
| FZF Keymaps | ✅ Complete | `fzf.lua` | Fuzzy finding (30+ keymaps) |
| LSP Keymaps | ✅ Complete | `lsp.lua` | Development tools (50+ keymaps) |
| AI Keymaps | ✅ Complete | `ai.lua` | Copilot integration (25+ keymaps) |
| Terminal Keymaps | ⏳ Pending | `terminal.lua` | Terminal management |

## Next Steps

1. ✅ **Create remaining core modules** (`editor.lua`, `navigation.lua`) - COMPLETED
2. ✅ **Migrate plugin-specific keymaps** to respective modules - COMPLETED
   - ✅ Created `git.lua` for Git workflow keymaps (fugitive, signify, lazygit)
   - ✅ Created `fzf.lua` for fuzzy finder integration 
   - ✅ Created `lsp.lua` for development tools (mason, conform, lint)
   - ✅ Created `ai.lua` for Copilot integration
3. ✅ **Add comprehensive tests** for each new module - COMPLETED (87 tests passing)
4. **Update which-key configuration** to use new groups
5. **Document breaking changes** (if any)
6. **Performance testing** to ensure no regression

## Recent Completions

### Task 2: Core Module Creation (✅ COMPLETED)
- **editor.lua**: Created with 40+ text editing keymaps including visual mode helpers, clipboard integration, text manipulation, and advanced editing operations
- **navigation.lua**: Created with 60+ navigation keymaps including window management, buffer operations, tab control, quickfix/location lists, and jump navigation
- **core.lua**: Refactored to contain only truly essential vim keymaps, with most functionality moved to specialized modules
- **init.lua**: Updated to load all three core modules (core, editor, navigation)
- **Tests**: Extended test suite to include comprehensive testing for all new modules (59 tests passing)

The modular keymap system now has a solid foundation with three core modules providing comprehensive keymap coverage.

### Task 3: Plugin Module Creation (✅ COMPLETED)
- **git.lua**: Created with 40+ Git workflow keymaps including fugitive operations (status, commit, push, pull, diff, blame, branches, stash), signify hunk navigation, and lazygit integration
- **fzf.lua**: Created with 30+ fuzzy finder keymaps including file finding, buffer management, content searching, command history, and Git integration with comprehensive FZF configuration
- **lsp.lua**: Created with 50+ LSP keymaps including navigation (go to definition/implementation/references), code actions, formatting, diagnostics, workspace management, Mason integration, conform formatting, and lint integration
- **ai.lua**: Created with 25+ AI keymaps including Copilot control (enable/disable/toggle), chat operations, predefined prompts (explain/review/fix/optimize/test/document), and workflow assistance
- **Tests**: Enhanced test suite to include comprehensive plugin module testing (87 tests total passing)

The keymap modernization system now provides complete coverage of all development workflows with intelligent conditional loading based on plugin availability.

## Commands for Development

- `:KeymapReload` - Reload the entire keymap system
- `:WhichKey` - Show which-key popup
- `:WhichKeyReload` - Reload which-key configuration

The framework is now complete and ready for systematic migration of existing keymaps to the new modular system.