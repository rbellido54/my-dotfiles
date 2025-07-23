# Technical Specification

This is the technical specification for the spec detailed in @.agent-os/specs/2025-07-22-core-config-migration/spec.md

> Created: 2025-07-22
> Version: 1.0.0

## Technical Requirements

- **Lua Compatibility** - All configuration must use valid Neovim Lua API calls
- **Module Structure** - Follow LazyVim directory patterns for consistency and future compatibility
- **Backward Compatibility** - Existing vim-plug and VimScript plugin configurations must continue working
- **Option Preservation** - All 47 settings from general/settings.vim must be migrated with identical behavior
- **Keymap Preservation** - All key bindings from keys/mappings.vim must work identically
- **Load Order** - Modules must load in correct sequence to avoid dependency issues
- **Error Handling** - Graceful error handling for missing modules or configuration issues

## Approach Options

**Option A: Direct Translation Approach**
- Pros: Minimal risk, exact behavior preservation, straightforward mapping
- Cons: May not follow all modern Lua patterns, less optimization opportunity

**Option B: Modern Lua Restructure** (Selected)
- Pros: Follows LazyVim patterns, better organization, future-ready structure
- Cons: Requires more careful testing to ensure behavior preservation

**Option C: Gradual Migration**
- Pros: Lower risk, can be done incrementally
- Cons: Extended migration period, mixed VimScript/Lua state

**Rationale:** Option B provides the best foundation for future migrations while still preserving current functionality. The modular structure will make future plugin system migration much easier.

## Module Structure Design

```
nvim/
├── init.lua                          # Main entry point
└── lua/
    └── config/
        ├── init.lua                  # Module loader
        ├── options.lua               # All vim options (from general/settings.vim)
        ├── keymaps.lua              # All key mappings (from keys/mappings.vim)
        └── autocmds.lua             # Auto commands (from general/settings.vim)
```

## Migration Mapping

### init.vim → init.lua
- Replace `source` commands with `require()` calls
- Keep vim-plug loading for compatibility
- Keep existing plugin config loading pattern
- Add new Lua config loading

### general/settings.vim → lua/config/options.lua
- Convert `set` commands to `vim.opt` assignments
- Convert `let g:` variables to `vim.g` assignments
- Migrate autocommands to separate module
- Preserve leader key setting

### keys/mappings.vim → lua/config/keymaps.lua
- Convert `nnoremap`, `inoremap`, `vnoremap` to `vim.keymap.set()`
- Convert `let g:` FZF settings to `vim.g` assignments
- Convert FZF commands and functions to Lua equivalents
- Preserve all key binding behaviors

## External Dependencies

**No new dependencies required** - This migration uses only built-in Neovim Lua API

## Compatibility Considerations

- **vim-plug Integration** - Must continue loading plugins via existing vim-plug setup
- **Plugin Configs** - Existing VimScript plugin configurations in plug-config/ must continue working
- **Theme Loading** - Current theme sourcing pattern must remain functional
- **FZF Configuration** - Complex FZF setup must be carefully converted to maintain functionality

## Testing Strategy

- **Functionality Testing** - Verify all key bindings work identically
- **Settings Verification** - Confirm all vim options are set correctly
- **Plugin Compatibility** - Ensure all plugins load and function properly
- **Startup Testing** - Verify Neovim starts without errors
- **Fallback Testing** - Test error handling for missing or malformed modules