# Plugin Migration Matrix

> Generated: 2025-07-22
> Total Plugins: 54
> Migration Planning for lazy.nvim

## Migration Categories

### 🟢 Ready for Lazy.nvim (20 plugins)
*Already Lua-native, minimal configuration changes needed*

| Plugin | Repository | Current Config | lazy.nvim Ready | Migration Notes |
|--------|------------|----------------|-----------------|-----------------|
| nvim-tree/nvim-tree.lua | nvim-tree/nvim-tree.lua | ✅ Lua | ✅ | Already well configured |
| folke/which-key.nvim | folke/which-key.nvim | ✅ Lua | ✅ | Already well configured |
| williamboman/mason.nvim | williamboman/mason.nvim | ✅ Lua | ✅ | Core dependency |
| williamboman/mason-lspconfig.nvim | williamboman/mason-lspconfig.nvim | ✅ Lua | ✅ | Mason ecosystem |
| neovim/nvim-lspconfig | neovim/nvim-lspconfig | ✅ Lua | ✅ | Update deprecated APIs |
| stevearc/conform.nvim | stevearc/conform.nvim | ✅ Lua | ✅ | Already configured |
| mfussenegger/nvim-lint | mfussenegger/nvim-lint | ✅ Lua | ✅ | Already configured |
| EdenEast/nightfox.nvim | EdenEast/nightfox.nvim | VimScript | ✅ | Simple config conversion |
| folke/tokyonight.nvim | folke/tokyonight.nvim | VimScript | ✅ | Simple config conversion |
| rebelot/kanagawa.nvim | rebelot/kanagawa.nvim | VimScript | ✅ | Simple config conversion |
| catppuccin/nvim | catppuccin/nvim | VimScript | ✅ | Simple config conversion |
| ellisonleao/gruvbox.nvim | ellisonleao/gruvbox.nvim | VimScript | ✅ | Simple config conversion |
| nvim-lua/plenary.nvim | nvim-lua/plenary.nvim | None | ✅ | Dependency only |
| chentoast/marks.nvim | chentoast/marks.nvim | ✅ Lua | ✅ | Already configured |
| kdheepak/lazygit.nvim | kdheepak/lazygit.nvim | None | ✅ | Simple key mapping |
| lukas-reineke/indent-blankline.nvim | lukas-reineke/indent-blankline.nvim | ✅ Lua | ✅ | Already configured |
| lukas-reineke/virt-column.nvim | lukas-reineke/virt-column.nvim | None | ✅ | Minimal config |
| sindrets/winshift.nvim | sindrets/winshift.nvim | ✅ Lua | ✅ | Already configured |
| norcalli/nvim-colorizer.lua | norcalli/nvim-colorizer.lua | ✅ Lua | ✅ | Already configured |
| nvim-tree/nvim-web-devicons | nvim-tree/nvim-web-devicons | None | ✅ | Dependency only |

### 🟡 Direct Lua Replacements (12 plugins)  
*Legacy plugins with modern Lua equivalents*

| Current Plugin | Lua Replacement | Repository | Migration Complexity | Notes |
|---------------|-----------------|------------|---------------------|--------|
| jiangmiao/auto-pairs | windwp/nvim-autopairs | windwp/nvim-autopairs | Low | Direct feature replacement |
| tpope/vim-commentary | numToStr/Comment.nvim | numToStr/Comment.nvim | Low | Enhanced functionality |
| tpope/vim-surround | kylechui/nvim-surround | kylechui/nvim-surround | Medium | Different key mappings |
| unblevable/quick-scope | phaazon/hop.nvim | phaazon/hop.nvim | Medium | Different motion paradigm |
| justinmk/vim-sneak | phaazon/hop.nvim | phaazon/hop.nvim | Medium | Combine with hop.nvim |
| mhinz/vim-signify | lewis6991/gitsigns.nvim | lewis6991/gitsigns.nvim | Low | Direct replacement |
| mhinz/vim-startify | goolord/alpha-nvim | goolord/alpha-nvim | Medium | Different configuration |
| voldikss/vim-floaterm | akinsho/toggleterm.nvim | akinsho/toggleterm.nvim | Medium | Enhanced terminal features |
| junegunn/goyo.vim | folke/zen-mode.nvim | folke/zen-mode.nvim | Low | Direct replacement |
| vim-airline/vim-airline | nvim-lualine/lualine.nvim | nvim-lualine/lualine.nvim | High | Different theming system |
| vim-airline/vim-airline-themes | nvim-lualine/lualine.nvim | nvim-lualine/lualine.nvim | High | Integrated with lualine |
| sheerun/vim-polyglot | nvim-treesitter/nvim-treesitter | nvim-treesitter/nvim-treesitter | High | Complete syntax overhaul |

### 🔵 Keep as VimScript (8 plugins)
*Mature plugins without better Lua alternatives*

| Plugin | Repository | Reason to Keep | lazy.nvim Compatible |
|--------|------------|----------------|---------------------|
| github/copilot.vim | github/copilot.vim | Official GitHub plugin | ✅ |
| CopilotC-Nvim/CopilotChat.nvim | CopilotC-Nvim/CopilotChat.nvim | Lua-native chat interface | ✅ |
| junegunn/fzf | junegunn/fzf | Core binary, not replaceable | ✅ |
| junegunn/fzf.vim | junegunn/fzf.vim | Extensive custom config | ✅ |
| airblade/vim-rooter | airblade/vim-rooter | Simple, reliable | ✅ |
| tpope/vim-fugitive | tpope/vim-fugitive | Best Git integration available | ✅ |
| tpope/vim-rhubarb | tpope/vim-rhubarb | GitHub integration for fugitive | ✅ |
| junegunn/gv.vim | junegunn/gv.vim | Git commit browser | ✅ |

### 🟠 Consider for Removal (6 plugins)
*Plugins that may be obsolete or redundant*

| Plugin | Repository | Reason for Removal | Alternative |
|--------|------------|-------------------|-------------|
| tpope/vim-repeat | tpope/vim-repeat | Built into nvim-surround | Remove with surround migration |
| qpkorr/vim-bufkill | qpkorr/vim-bufkill | Can use built-in :bdelete | Custom function or remove |
| honza/vim-snippets | honza/vim-snippets | Not using snippet engine | Remove if not needed |
| tek/vim-textobj-ruby | tek/vim-textobj-ruby | Language-specific, treesitter better | Treesitter text objects |
| kana/vim-textobj-user | kana/vim-textobj-user | Dependency for ruby textobj | Remove with ruby plugin |
| wellle/targets.vim | wellle/targets.vim | Redundant with treesitter | Treesitter text objects |

### 🟣 Theme Plugins Analysis (15 plugins)
*Color scheme migration status*

| Theme Plugin | Status | Migration Path | Notes |
|-------------|--------|----------------|-------|
| EdenEast/nightfox.nvim | ✅ Current | Ready | Already Lua-native |
| folke/tokyonight.nvim | Ready | Ready | Already Lua-native |
| rebelot/kanagawa.nvim | Ready | Ready | Already Lua-native |
| catppuccin/nvim | Ready | Ready | Already Lua-native |
| ellisonleao/gruvbox.nvim | Ready | Ready | Already Lua-native |
| sainnhe/everforest | Compatible | Keep | Has Lua support |
| joshdick/onedark.vim | Legacy | Replace | Use navarasu/onedark.nvim |
| chriskempson/base16-vim | Legacy | Replace | Use RRethy/base16-nvim |
| rafamadriz/neon | Compatible | Keep | Has Lua support |
| ajmwagar/vim-deus | Legacy | Keep/Replace | Find Lua alternative |
| mhartington/oceanic-next | Legacy | Keep/Replace | Find Lua alternative |
| yorickpeterse/vim-paper | Legacy | Keep/Replace | Minimal theme |
| eldritch-theme/eldritch.nvim | Ready | Ready | Already Lua-native |

## Migration Phases

### Phase 1: Foundation (High Priority)
1. **Core Infrastructure**: mason, lspconfig, plenary
2. **Essential UI**: nvim-tree, which-key, web-devicons
3. **Development Tools**: conform, nvim-lint, copilot

### Phase 2: Direct Replacements (Medium Priority)
1. **Text Editing**: autopairs, Comment.nvim, nvim-surround  
2. **Git Integration**: gitsigns.nvim
3. **UI Enhancement**: alpha-nvim, zen-mode

### Phase 3: Complex Migrations (Low Priority)
1. **Syntax**: nvim-treesitter (major change)
2. **Statusline**: lualine (theming implications)
3. **Motion**: hop.nvim (workflow change)

## lazy.nvim Configuration Template

```lua
-- Example lazy.nvim spec for migrated plugins
return {
  -- Core functionality
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.nvim-tree")
    end,
    keys = {
      { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle file explorer" },
    },
  },

  -- Replace auto-pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Replace vim-commentary  
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    config = function()
      require("Comment").setup()
    end,
  },
}
```

## Migration Checklist

### Pre-Migration
- [ ] Backup current configuration
- [ ] Document custom key mappings
- [ ] List essential workflows

### Plugin Manager Migration  
- [ ] Install lazy.nvim
- [ ] Convert plugin specifications
- [ ] Test essential plugins

### Configuration Migration
- [ ] Convert init.vim to init.lua
- [ ] Migrate core settings
- [ ] Update key mappings

### Testing & Validation
- [ ] Verify all features work
- [ ] Check startup time improvement
- [ ] Validate LSP functionality
- [ ] Test Git workflows

### Post-Migration Cleanup
- [ ] Remove vim-plug
- [ ] Clean unused configuration files
- [ ] Update documentation

## Success Metrics

1. **Plugin Count Reduction**: 54 → ~45 plugins (remove redundant)
2. **Startup Performance**: Lazy loading implementation  
3. **Configuration Lines**: Reduce VimScript from ~500 to ~50 lines
4. **Maintainability**: Modern Lua patterns throughout
5. **Feature Parity**: No functionality regression

---

*This matrix provides a systematic approach to migrating from vim-plug to lazy.nvim while modernizing the entire plugin ecosystem.*