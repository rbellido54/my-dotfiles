# Spec Tasks

These are the tasks to be completed for the spec detailed in @.agent-os/specs/2025-07-23-keymapping-modernization/spec.md

> Created: 2025-07-23
> Status: Ready for Implementation

## Tasks

- [ ] 1. Create Modular Keymap Structure
  - [ ] 1.1 Write tests for keymap module loading and organization
  - [ ] 1.2 Create lua/config/keymaps/ directory structure
  - [ ] 1.3 Implement init.lua as main entry point for keymap modules
  - [ ] 1.4 Set up conditional loading mechanism for plugin-specific keymaps
  - [ ] 1.5 Verify all keymap modules can be loaded without errors

- [ ] 2. Migrate Core Editor Keymaps to Lua
  - [ ] 2.1 Write tests for core editor keymap functionality
  - [ ] 2.2 Create core.lua module with window navigation keymaps
  - [ ] 2.3 Migrate buffer navigation and text manipulation keymaps
  - [ ] 2.4 Convert insert mode shortcuts and completion keymaps
  - [ ] 2.5 Test that all core keymaps function identically to VimScript versions
  - [ ] 2.6 Verify all tests pass for core keymap migration

- [ ] 3. Implement Leader-Based Command Organization
  - [ ] 3.1 Write tests for leader keymap registration and execution
  - [ ] 3.2 Create leader.lua module with file operations and search keymaps
  - [ ] 3.3 Migrate git operations and buffer management leader commands
  - [ ] 3.4 Add utility functions and toggle commands with leader prefix
  - [ ] 3.5 Test leader keymap functionality and verify no conflicts exist
  - [ ] 3.6 Verify all tests pass for leader keymap implementation

- [ ] 4. Integrate Which-Key Registration System
  - [ ] 4.1 Write tests for which-key registration and menu display
  - [ ] 4.2 Create which-key.lua module for centralized registration management
  - [ ] 4.3 Register all core and leader keymaps with descriptive labels
  - [ ] 4.4 Implement logical grouping for related commands (git, buffer, AI, etc.)
  - [ ] 4.5 Test which-key menu functionality and group organization
  - [ ] 4.6 Verify all tests pass for which-key integration

- [ ] 5. Migrate Plugin-Specific Keymaps
  - [ ] 5.1 Write tests for plugin keymap conditional loading
  - [ ] 5.2 Create plugins.lua module with conditional loading logic
  - [ ] 5.3 Migrate NvimTree, FZF, and Copilot keymaps to new structure
  - [ ] 5.4 Move Git plugin keymaps (fugitive, signify) to plugins module
  - [ ] 5.5 Test plugin keymap functionality with and without plugins loaded
  - [ ] 5.6 Verify all tests pass for plugin keymap migration

- [ ] 6. Clean Up Legacy VimScript and Finalize
  - [ ] 6.1 Write integration tests comparing old vs new keymap behavior
  - [ ] 6.2 Update main keymaps.lua to use new modular structure
  - [ ] 6.3 Remove keys/mappings.vim file and any duplicate VimScript mappings
  - [ ] 6.4 Verify no keymap conflicts or missing functionality exists
  - [ ] 6.5 Test complete keymap system functionality end-to-end
  - [ ] 6.6 Verify all tests pass and system is ready for use