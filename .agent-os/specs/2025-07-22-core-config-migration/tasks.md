# Spec Tasks

These are the tasks to be completed for the spec detailed in @.agent-os/specs/2025-07-22-core-config-migration/spec.md

> Created: 2025-07-22
> Status: Ready for Implementation

## Tasks

- [x] 1. Create Lua Config Module Structure
  - [x] 1.1 Create lua/config/ directory structure
  - [x] 1.2 Create lua/config/init.lua module loader
  - [x] 1.3 Test module loading functionality
  - [x] 1.4 Verify all modules load without errors

- [x] 2. Migrate Options Configuration
  - [x] 2.1 Write tests for options verification
  - [x] 2.2 Create lua/config/options.lua from general/settings.vim
  - [x] 2.3 Convert all vim settings to vim.opt syntax
  - [x] 2.4 Test all options are set correctly
  - [x] 2.5 Verify all tests pass

- [x] 3. Migrate Key Mappings
  - [x] 3.1 Write tests for keymap functionality
  - [x] 3.2 Create lua/config/keymaps.lua from keys/mappings.vim
  - [x] 3.3 Convert all key bindings to vim.keymap.set() syntax
  - [x] 3.4 Convert FZF configuration to Lua
  - [x] 3.5 Test all key bindings work identically
  - [x] 3.6 Verify all tests pass

- [x] 4. Extract Auto Commands
  - [x] 4.1 Write tests for autocmd functionality
  - [x] 4.2 Create lua/config/autocmds.lua
  - [x] 4.3 Convert autocommands from general/settings.vim
  - [x] 4.4 Test autocmd behavior matches original
  - [x] 4.5 Verify all tests pass

- [x] 5. Create New init.lua Entry Point
  - [x] 5.1 Write tests for init.lua loading sequence
  - [x] 5.2 Create init.lua with proper module loading
  - [x] 5.3 Preserve vim-plug and plugin config loading
  - [x] 5.4 Test startup sequence works correctly
  - [x] 5.5 Verify all functionality preserved
  - [x] 5.6 Verify all tests pass

- [ ] 6. Backup and Transition
  - [ ] 6.1 Create backup of original init.vim
  - [ ] 6.2 Test complete configuration with full startup
  - [ ] 6.3 Verify plugin compatibility
  - [ ] 6.4 Test theme loading functionality
  - [ ] 6.5 Perform comprehensive manual testing
  - [ ] 6.6 Verify all tests pass