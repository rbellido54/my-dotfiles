# Neovim VimScript to Lua Migration Audit Report

> Generated: 2025-07-22
> Configuration Path: `/Users/rmb/devel/my-dotfiles/nvim/`
> Total Files Analyzed: 28+ VimScript files, 17 Lua files

## Executive Summary

The current Neovim configuration uses vim-plug for plugin management with 54 plugins installed. The setup is a hybrid VimScript/Lua configuration with core functionality in VimScript but modern plugins increasingly using Lua configurations. This audit identifies significant opportunities for migration to lazy.nvim and modern Lua patterns.

## Current Configuration Architecture

### File Structure Overview
```
nvim/
├── init.vim                    # Main entry point (VimScript)
├── general/settings.vim        # Core Neovim settings
├── keys/mappings.vim          # Key bindings and FZF configuration
├── vim-plug/plugins.vim       # Plugin definitions (54 plugins)
├── plug-config/              # VimScript plugin configurations (10 files)
├── themes/                   # Theme configurations (13 files)
└── lua/                      # Lua configurations (17 files)
    ├── general.lua           # Lua initialization
    ├── lsp-config.lua        # LSP setup
    └── plug-config/          # Lua plugin configs (14 files)
```

## Plugin Ecosystem Analysis

### Current Plugin Management
- **Plugin Manager**: vim-plug
- **Total Plugins**: 54 plugins
- **Plugin Categories**:
  - Themes: 15 color schemes
  - LSP/Completion: 6 plugins (Mason, LSP-config, etc.)
  - File Navigation: 7 plugins (fzf, nvim-tree, etc.)
  - Git Integration: 4 plugins (fugitive, signify, etc.)
  - Development Tools: 8 plugins (copilot, linting, formatting)
  - UI Enhancement: 14 plugins (airline, which-key, etc.)

### Plugin Lua Compatibility Matrix

#### ✅ Already Lua-Native (Modern)
| Plugin | Current Version | Migration Status |
|--------|----------------|------------------|
| nvim-tree.lua | ✓ | Ready for lazy.nvim |
| which-key.nvim | ✓ | Ready for lazy.nvim |
| mason.nvim | ✓ | Ready for lazy.nvim |
| nvim-lspconfig | ✓ | Ready for lazy.nvim |
| conform.nvim | ✓ | Ready for lazy.nvim |
| nvim-lint | ✓ | Ready for lazy.nvim |
| nightfox.nvim | ✓ | Ready for lazy.nvim |
| tokyonight.nvim | ✓ | Ready for lazy.nvim |
| kanagawa.nvim | ✓ | Ready for lazy.nvim |
| catppuccin | ✓ | Ready for lazy.nvim |
| gruvbox.nvim | ✓ | Ready for lazy.nvim |
| plenary.nvim | ✓ | Ready for lazy.nvim |
| marks.nvim | ✓ | Ready for lazy.nvim |
| lazygit.nvim | ✓ | Ready for lazy.nvim |
| indent-blankline.nvim | ✓ | Ready for lazy.nvim |
| virt-column.nvim | ✓ | Ready for lazy.nvim |
| winshift.nvim | ✓ | Ready for lazy.nvim |
| nvim-colorizer.lua | ✓ | Ready for lazy.nvim |
| nvim-web-devicons | ✓ | Ready for lazy.nvim |
| CopilotChat.nvim | ✓ | Ready for lazy.nvim |

#### 🔄 Lua Compatible (VimScript Config)
| Plugin | Migration Path | Notes |
|--------|---------------|-------|
| copilot.vim | Keep or migrate to copilot.lua | Current setup works |
| fzf + fzf.vim | Consider telescope.nvim | Major workflow change |
| vim-airline | Consider lualine | UI framework change |
| vim-startify | Consider alpha-nvim/dashboard | Welcome screen |

#### ⚠️ Legacy VimScript Only
| Plugin | Lua Alternative | Migration Impact |
|--------|----------------|------------------|
| vim-polyglot | nvim-treesitter | Syntax highlighting overhaul |
| auto-pairs | nvim-autopairs | Simple replacement |
| vim-commentary | Comment.nvim | Direct replacement |
| quick-scope | hop.nvim/leap.nvim | Motion enhancement |
| vim-sneak | hop.nvim/leap.nvim | Motion enhancement |
| vim-fugitive | Keep (no better alternative) | Git workflow dependency |
| vim-surround | nvim-surround | Direct replacement |
| vim-repeat | Built into nvim-surround | Can remove |
| vim-bufkill | Keep or custom function | Buffer management |
| vim-floaterm | toggleterm.nvim | Terminal management |
| goyo.vim | zen-mode.nvim | Distraction-free mode |
| vim-signify | gitsigns.nvim | Git diff signs |
| vim-rooter | Built into nvim-tree | Can remove |

## VimScript Configuration Analysis

### Core Configuration Files

#### 1. **init.vim** (13 lines) - **SIMPLE**
- **Current Function**: Entry point, sources all configuration files
- **Migration Approach**: Convert to init.lua, replace source commands with require()
- **Dependencies**: None
- **Complexity**: Low - straightforward file sourcing

#### 2. **general/settings.vim** (47 lines) - **SIMPLE**
- **Current Function**: Core Neovim settings (leader, options, autocmds)
- **Migration Approach**: Direct conversion to vim.opt and vim.g
- **Key Settings**: Leader key, indentation, UI options, clipboard
- **Complexity**: Low - mostly option settings

#### 3. **keys/mappings.vim** (111 lines) - **MODERATE**
- **Current Function**: Key bindings, FZF configuration, custom functions
- **Migration Approach**: Convert to vim.keymap.set(), modernize FZF setup
- **Key Features**: Window navigation, FZF integration, Ripgrep setup
- **Complexity**: Medium - contains custom functions and FZF configuration

### Plugin Configuration Files

#### VimScript Configurations (plug-config/*.vim)
| File | Lines | Complexity | Migration Notes |
|------|-------|------------|----------------|
| start-screen.vim | 34 | Simple | Convert to alpha-nvim |
| signify.vim | ~15 | Simple | Replace with gitsigns.nvim |
| sneak.vim | ~10 | Simple | Replace with hop.nvim |
| quickscope.vim | ~8 | Simple | Replace with hop.nvim |
| floaterm.vim | ~20 | Simple | Replace with toggleterm.nvim |
| goyo.vim | ~5 | Simple | Replace with zen-mode.nvim |
| coq.vim | ~25 | Simple | Remove (using Mason/LSP) |
| ale.vim | ~30 | Simple | Remove (using nvim-lint) |
| tagbar.vim | ~15 | Simple | Remove or replace |
| vim-bufkill.vim | ~10 | Simple | Custom function or remove |

### Theme Configuration Files

#### Current Theme Structure (themes/*.vim)
| File | Status | Migration Path |
|------|--------|----------------|
| nightfox.vim | ✓ Active | Already Lua-native |
| airline.vim | Legacy | Replace with lualine |
| base16.vim | Legacy | Update to base16-nvim |
| catpuccin.vim | Ready | Already Lua-native |
| deus.vim | Legacy | Keep or find alternative |
| everforest.vim | Ready | Has Lua support |
| gruvbox.vim | Ready | Already Lua-native |
| kanagawa.vim | Ready | Already Lua-native |
| neon.vim | Ready | Has Lua support |
| oceanic-next.vim | Legacy | Find Lua alternative |
| onedark.vim | Legacy | Replace with onedark.nvim |
| paper.vim | Legacy | Keep or find alternative |
| tokyonight.vim | Ready | Already Lua-native |

## Current Lua Usage Analysis

The configuration already has significant Lua adoption:

### Existing Lua Files (17 files)
- **general.lua**: Bootstrap and plugin loading
- **lsp-config.lua**: Mason and LSP setup (needs modernization)
- **plug-colorizer.lua**: Simple plugin setup
- **mappings.lua**: Minimal key mapping
- **utils.lua**: Utility functions
- **plug-config/**: 14 plugin-specific Lua configurations

### Lua Configuration Quality Assessment
- ✅ **Modern Patterns**: nvim-tree, which-key configurations
- ⚠️ **Outdated API Usage**: lsp-config.lua uses deprecated vim.lsp.config
- ⚠️ **Mixed Patterns**: Some Lua files still use old vim.g patterns

## Migration Complexity Matrix

### Simple Migrations (1-2 days each)
- Core settings (settings.vim → lua/config/options.lua)
- Theme configurations (most themes already Lua-native)
- Basic plugin configs (auto-pairs, commentary, surround)

### Moderate Migrations (3-5 days each)  
- Key mappings with FZF integration
- LSP configuration modernization
- Statusline (airline → lualine)

### Complex Migrations (1-2 weeks each)
- Plugin manager migration (vim-plug → lazy.nvim)
- Syntax highlighting (vim-polyglot → treesitter)
- File navigation workflow (current FZF setup → telescope or keep FZF)

## Dependency Mapping

### Critical Dependencies
1. **FZF Integration**: Deep integration with key mappings, requires careful migration
2. **Airline Theme Sync**: Theme changes need statusline coordination
3. **LSP Configuration**: Mason setup needs coordination with plugin loading

### Plugin Interdependencies
- **nvim-web-devicons** ← nvim-tree, lualine, alpha-nvim
- **plenary.nvim** ← telescope, gitsigns, many modern plugins  
- **Mason** ← LSP servers, formatters, linters

## Recommendations

### Phase 1: Foundation (Week 1-2)
1. Migrate core settings to Lua
2. Update LSP configuration to modern API
3. Convert simple plugin configs

### Phase 2: Plugin Ecosystem (Week 3-4)  
1. Migrate to lazy.nvim
2. Replace legacy plugins with Lua alternatives
3. Implement treesitter for syntax highlighting

### Phase 3: Advanced Features (Week 5-6)
1. Advanced key mapping migrations
2. Statusline modernization
3. Fine-tuning and optimization

## Risk Assessment

### Low Risk
- Theme migrations (most already Lua-native)
- Core settings migration
- Simple plugin replacements

### Medium Risk  
- Plugin manager migration (requires testing all plugins)
- LSP configuration changes (affects development workflow)

### High Risk
- FZF to Telescope migration (major workflow change)
- Syntax highlighting migration (affects all file types)

## Success Metrics

1. **Performance**: Startup time improvement with lazy loading
2. **Maintainability**: Reduced configuration complexity
3. **Functionality**: No loss of current features
4. **Ecosystem**: Access to modern Neovim plugins and features

---

*This audit provides the foundation for systematic migration to modern Lua-based Neovim configuration with lazy.nvim plugin management.*