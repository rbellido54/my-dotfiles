# Tests Specification

This is the tests coverage details for the spec detailed in @.agent-os/specs/2025-07-22-core-config-migration/spec.md

> Created: 2025-07-22
> Version: 1.0.0

## Test Coverage

### Unit Tests

**Config Module Loading**
- Test `require('config')` loads without errors
- Test individual module loading (options, keymaps, autocmds)
- Test error handling for malformed modules
- Test module dependency resolution

**Options Module**
- Verify all vim options are set correctly using `:set all`
- Test leader key is set to space
- Test encoding settings (utf-8)
- Test indentation settings (2 spaces, smart indent)
- Test UI settings (line numbers, cursor line, etc.)

**Keymaps Module**
- Test each key binding produces expected behavior
- Test FZF key bindings (Ctrl-f for file search)
- Test buffer navigation (Tab/Shift-Tab)
- Test window navigation (Ctrl-hjkl)
- Test window resizing (Alt-hjkl)
- Test insert mode mappings (jj to escape)

### Integration Tests

**Startup Sequence**
- Test Neovim starts without errors with new init.lua
- Test all modules load in correct order
- Test vim-plug plugins still load correctly
- Test existing plugin configurations remain functional

**Configuration Compatibility**
- Test theme loading continues to work
- Test plugin configs in plug-config/ directory load properly
- Test existing Lua modules (LSP, copilot, etc.) continue working
- Test airline configuration loads correctly

**FZF Integration**
- Test Files command works with Ctrl-f binding
- Test Rg command functions properly
- Test custom FZF colors and layout
- Test FZF history functionality
- Test git grep integration

### Feature Tests

**Complete Workflow Testing**
- Start Neovim and verify identical appearance to current setup
- Test file editing workflow with all key bindings
- Test plugin functionality (file tree, git, LSP, etc.)
- Test theme switching capability
- Test buffer and window management

**Error Recovery Testing**
- Test behavior with missing config modules
- Test fallback when Lua modules fail to load
- Test error messages are helpful and non-blocking

### Mocking Requirements

**File System Mocking**
- Mock missing config files to test error handling
- Mock FZF executable for testing FZF configuration

**Neovim API Mocking**
- Mock vim.opt for testing option setting
- Mock vim.keymap.set for testing keymap registration
- Mock vim.api for testing autocommand creation

## Manual Testing Checklist

- [ ] Neovim starts without errors
- [ ] Leader key (space) works correctly
- [ ] All key bindings function identically
- [ ] FZF file search (Ctrl-f) works
- [ ] Buffer navigation (Tab/Shift-Tab) works
- [ ] Window navigation (Ctrl-hjkl) works
- [ ] Window resizing (Alt-hjkl) works
- [ ] Insert mode escape (jj) works
- [ ] Line numbers and cursor line display correctly
- [ ] Indentation settings work (2 spaces)
- [ ] Plugins load and function properly
- [ ] Theme applies correctly
- [ ] No error messages on startup
- [ ] All existing functionality preserved