# Technical Specification

This is the technical specification for the spec detailed in @.agent-os/specs/2025-07-23-keymapping-modernization/spec.md

> Created: 2025-07-23
> Version: 1.0.0

## Technical Requirements

### Core Migration Requirements
- **VimScript Elimination:** Complete removal of keys/mappings.vim file and migration to Lua
- **API Modernization:** All mappings use vim.keymap.set() with consistent option tables
- **Mode Specificity:** Proper mode specification (normal, insert, visual, command) for each mapping
- **Option Consistency:** Standardized use of { noremap = true, silent = true } and other options

### Which-Key Integration Requirements
- **Complete Registration:** All leader-based and significant non-leader mappings registered with which-key
- **Descriptive Labels:** Every mapping has a clear, concise description explaining its function
- **Logical Grouping:** Related commands grouped under common prefixes with group labels
- **Visual Consistency:** Consistent naming patterns and group organization

### Organization Requirements
- **Modular Structure:** Separate modules for core editor keymaps vs plugin-specific keymaps
- **Loading Strategy:** Plugin keymaps loaded conditionally when plugins are available
- **Override Support:** Clear mechanism for user customizations without modifying core files
- **Documentation:** Each module clearly documents its purpose and keymap categories

## Approach Options

**Option A: Single Large Keymap Module**
- Pros: Simple structure, everything in one place
- Cons: Hard to maintain, no separation of concerns, plugin coupling

**Option B: Category-Based Module Structure** (Selected)
- Pros: Logical organization, maintainable, clear separation, testable
- Cons: Slightly more complex initial setup

**Option C: Plugin-Distributed Keymaps**
- Pros: Perfect coupling with plugin configs
- Cons: Hard to get overview, scattered definitions, which-key registration complexity

**Rationale:** Option B provides the best balance of maintainability and organization. It allows for clear separation between core editor functionality and plugin-specific features while keeping related keymaps grouped together. This approach also facilitates easier testing and user customization.

## Implementation Architecture

### Module Structure
```
lua/config/keymaps/
├── init.lua          -- Main entry point, loads all keymap modules
├── core.lua          -- Core editor keymaps (movement, editing, windows)
├── leader.lua        -- Leader-based command mappings
├── plugins.lua       -- Plugin-specific keymaps
└── which-key.lua     -- Which-key configurations and registrations
```

### Loading Strategy
- **Core keymaps:** Loaded immediately during Neovim startup
- **Plugin keymaps:** Loaded conditionally based on plugin availability
- **Which-key registration:** Happens after plugin loading to ensure all mappings are captured

### Key Categories

#### Core Editor Keymaps (core.lua)
- Window navigation (Ctrl+hjkl)
- Window resizing (Alt+hjkl)  
- Buffer navigation (Tab, Shift+Tab)
- Text manipulation (indentation, line operations)
- Insert mode shortcuts (jj escape, completion navigation)

#### Leader-Based Commands (leader.lua)
- File operations and search
- Git operations
- Buffer management
- Utility functions (toggle search highlight, add lines)

#### Plugin-Specific Keymaps (plugins.lua)
- NvimTree file explorer
- FZF/telescope search
- Copilot AI integration
- LSP-related mappings
- Git integration (fugitive, signify)

## External Dependencies

**No new dependencies required** - leveraging existing plugins:
- **which-key.nvim** - Already installed and configured
- **Standard Neovim API** - Using vim.keymap.set() and existing APIs

## Migration Strategy

### Phase 1: Structure Setup
1. Create new keymap module structure
2. Set up loading mechanism in main keymaps.lua
3. Preserve existing functionality during transition

### Phase 2: Core Migration
1. Migrate basic editor keymaps from VimScript to Lua
2. Test each mapping category thoroughly
3. Register with which-key as each category is migrated

### Phase 3: Plugin Integration
1. Move plugin-specific keymaps to appropriate modules
2. Ensure conditional loading works properly
3. Complete which-key registration for all mappings

### Phase 4: Cleanup and Polish
1. Remove legacy VimScript file
2. Verify no conflicts or missing mappings
3. Update documentation and cross-references

## Compatibility Considerations

- **Existing Muscle Memory:** All current key combinations preserved
- **Plugin Compatibility:** Ensure plugin-defined keymaps still work
- **User Customization:** Maintain ability for users to override specific mappings
- **Performance:** No startup time degradation from new structure