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

- [ ] 2. Migrate Options Configuration
  - [ ] 2.1 Write tests for options verification
  - [ ] 2.2 Create lua/config/options.lua from general/settings.vim
  - [ ] 2.3 Convert all vim settings to vim.opt syntax
  - [ ] 2.4 Test all options are set correctly
  - [ ] 2.5 Verify all tests pass

- [ ] 3. Migrate Key Mappings
  - [ ] 3.1 Write tests for keymap functionality
  - [ ] 3.2 Create lua/config/keymaps.lua from keys/mappings.vim
  - [ ] 3.3 Convert all key bindings to vim.keymap.set() syntax
  - [ ] 3.4 Convert FZF configuration to Lua
  - [ ] 3.5 Test all key bindings work identically
  - [ ] 3.6 Verify all tests pass

- [ ] 4. Extract Auto Commands
  - [ ] 4.1 Write tests for autocmd functionality
  - [ ] 4.2 Create lua/config/autocmds.lua
  - [ ] 4.3 Convert autocommands from general/settings.vim
  - [ ] 4.4 Test autocmd behavior matches original
  - [ ] 4.5 Verify all tests pass

- [ ] 5. Create New init.lua Entry Point
  - [ ] 5.1 Write tests for init.lua loading sequence
  - [ ] 5.2 Create init.lua with proper module loading
  - [ ] 5.3 Preserve vim-plug and plugin config loading
  - [ ] 5.4 Test startup sequence works correctly
  - [ ] 5.5 Verify all functionality preserved
  - [ ] 5.6 Verify all tests pass

- [ ] 6. Backup and Transition
  - [ ] 6.1 Create backup of original init.vim
  - [ ] 6.2 Test complete configuration with full startup
  - [ ] 6.3 Verify plugin compatibility
  - [ ] 6.4 Test theme loading functionality
  - [ ] 6.5 Perform comprehensive manual testing
  - [ ] 6.6 Verify all tests pass