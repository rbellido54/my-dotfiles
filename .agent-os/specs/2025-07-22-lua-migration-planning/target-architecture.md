# Target LazyVim-Style Architecture

> Generated: 2025-07-22
> Target: Modern Lua-based Neovim configuration with lazy.nvim

## Overview

This document defines the target directory structure and module organization for the migrated Neovim configuration, following LazyVim patterns and modern Lua practices.

## Target Directory Structure

```
nvim/
├── init.lua                          # Entry point - minimal bootstrap
├── lazy-lock.json                    # Plugin lockfile (auto-generated)
├── lua/
│   ├── config/                       # Core Neovim configuration
│   │   ├── init.lua                  # Configuration loader
│   │   ├── options.lua               # Vim options (from settings.vim)
│   │   ├── keymaps.lua               # Key mappings (from mappings.vim)
│   │   ├── autocmds.lua              # Autocommands
│   │   └── lazy.lua                  # Lazy.nvim bootstrap
│   ├── plugins/                      # Plugin specifications
│   │   ├── init.lua                  # Plugin loader
│   │   ├── core/                     # Essential plugins
│   │   │   ├── mason.lua             # LSP, DAP, linter, formatter installer
│   │   │   ├── lspconfig.lua         # LSP configurations
│   │   │   ├── treesitter.lua        # Syntax highlighting
│   │   │   └── nvim-cmp.lua          # Completion engine (future)
│   │   ├── editor/                   # Editor enhancements
│   │   │   ├── autopairs.lua         # Auto-pairing
│   │   │   ├── comment.lua           # Commenting
│   │   │   ├── surround.lua          # Surround operations
│   │   │   ├── hop.lua               # Motion enhancement
│   │   │   └── which-key.lua         # Key binding help
│   │   ├── ui/                       # User interface
│   │   │   ├── colorscheme.lua       # Theme configuration
│   │   │   ├── lualine.lua           # Status line
│   │   │   ├── nvim-tree.lua         # File explorer
│   │   │   ├── alpha.lua             # Start screen
│   │   │   ├── indent-blankline.lua  # Indentation guides
│   │   │   └── noice.lua             # UI enhancements (future)
│   │   ├── tools/                    # Development tools
│   │   │   ├── git.lua               # Git integration (fugitive, gitsigns)
│   │   │   ├── fzf.lua               # Fuzzy finder (keep current setup)
│   │   │   ├── terminal.lua          # Terminal integration
│   │   │   ├── copilot.lua           # AI assistance
│   │   │   ├── formatting.lua        # Code formatting
│   │   │   └── linting.lua           # Code linting
│   │   └── extras/                   # Optional/experimental plugins
│   │       ├── zen-mode.lua          # Distraction-free editing
│   │       └── winshift.lua          # Window management
│   ├── util/                         # Utility functions
│   │   ├── init.lua                  # Utility loader
│   │   ├── icons.lua                 # Icon definitions
│   │   ├── colors.lua                # Color utilities
│   │   ├── keymaps.lua               # Keymap helpers
│   │   └── lsp.lua                   # LSP utilities
│   └── themes/                       # Custom theme configurations
│       ├── init.lua                  # Theme loader
│       ├── nightfox.lua              # Current theme config
│       └── variants.lua              # Theme variants/switching
└── .gitignore                        # Git ignore (lazy-lock.json, etc.)
```

## Module Architecture

### 1. Bootstrap & Entry Point

#### `init.lua` (Root)
```lua
-- Bootstrap lazy.nvim and load configuration
require("config.lazy")
```

#### `lua/config/lazy.lua`
```lua
-- Install and setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration first
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Setup lazy.nvim
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
```

### 2. Core Configuration

#### `lua/config/options.lua`
```lua
-- Migrated from general/settings.vim
local opt = vim.opt

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.showmode = false

-- Editor behavior
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false

-- Files
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 300

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"
```

#### `lua/config/keymaps.lua`
```lua
-- Migrated from keys/mappings.vim
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Escape alternatives
map("i", "jj", "<Esc>", opts)
map("n", "<C-c>", "<Esc>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window resizing
map("n", "<M-j>", ":resize -2<CR>", opts)
map("n", "<M-k>", ":resize +2<CR>", opts)
map("n", "<M-h>", ":vertical resize -2<CR>", opts)
map("n", "<M-l>", ":vertical resize +2<CR>", opts)

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Save and quit
map("n", "<C-s>", ":w<CR>", opts)
map("n", "<C-Q>", ":wq!<CR>", opts)

-- Better tabbing
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Line manipulation
map("n", "<Leader>o", "o<Esc>^Da", opts)
map("n", "<Leader>O", "O<Esc>^Da", opts)
```

### 3. Plugin Specifications

#### `lua/plugins/init.lua`
```lua
-- Load all plugin categories
return {
  { import = "plugins.core" },
  { import = "plugins.editor" },
  { import = "plugins.ui" },
  { import = "plugins.tools" },
  { import = "plugins.extras" },
}
```

#### Example Plugin Spec: `lua/plugins/ui/nvim-tree.lua`
```lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle file explorer" },
  },
  config = function()
    -- Migrate from lua/plug-config/nvim-tree.lua
    require("nvim-tree").setup({
      -- Current configuration preserved
      sort_by = "name",
      view = { adaptive_size = true },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    })
  end,
}
```

### 4. Utility Modules

#### `lua/util/icons.lua`
```lua
return {
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    File = " ",
    Module = " ",
    Namespace = " ",
    -- ... more LSP kinds
  },
}
```

## Migration Mapping

### File Migration Matrix

| Current Path | Target Path | Migration Type |
|-------------|-------------|----------------|
| `init.vim` | `init.lua` | Convert to minimal bootstrap |
| `general/settings.vim` | `lua/config/options.lua` | Direct VimScript → Lua conversion |
| `keys/mappings.vim` | `lua/config/keymaps.lua` | Convert mappings, extract FZF |
| `plug-config/*.vim` | `lua/plugins/*/*.lua` | Convert to lazy.nvim specs |
| `lua/plug-config/*.lua` | `lua/plugins/*/*.lua` | Restructure as lazy specs |
| `themes/*.vim` | `lua/plugins/ui/colorscheme.lua` | Consolidate theme management |
| `vim-plug/plugins.vim` | `lua/plugins/*/` | Convert to lazy.nvim specs |

### Configuration Patterns

#### Current Pattern (VimScript)
```vim
" vim-plug plugin definition
Plug 'nvim-tree/nvim-tree.lua'

" Separate configuration file
source $HOME/.config/nvim/lua/plug-config/nvim-tree.lua
```

#### Target Pattern (Lazy.nvim)
```lua
-- Self-contained plugin specification
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle file explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      -- configuration here
    })
  end,
}
```

## Performance Optimizations

### Lazy Loading Strategies

1. **Event-based Loading**
   ```lua
   { "windwp/nvim-autopairs", event = "InsertEnter" }
   ```

2. **Key-based Loading**
   ```lua
   { "folke/which-key.nvim", keys = { "<leader>" } }
   ```

3. **Command-based Loading**
   ```lua
   { "akinsho/toggleterm.nvim", cmd = { "ToggleTerm" } }
   ```

4. **Filetype-based Loading**
   ```lua
   { "someone/ruby-plugin", ft = "ruby" }
   ```

### Startup Sequence

1. **Immediate Load**: Essential UI (colorscheme, statusline)
2. **Fast Load**: Core editing (autopairs, comment)
3. **Lazy Load**: Feature plugins (git, terminal)
4. **On-demand**: Heavy plugins (LSP servers, formatters)

## Benefits of Target Architecture

### 1. **Performance**
- Lazy loading reduces startup time
- Conditional loading based on usage
- Better memory management

### 2. **Maintainability**  
- Self-contained plugin specifications
- Clear dependency management
- Consistent configuration patterns

### 3. **Discoverability**
- Logical file organization
- Plugin grouping by functionality
- Clear separation of concerns

### 4. **Extensibility**
- Easy to add new plugins
- Simple to modify configurations
- Support for user customizations

## Implementation Strategy

### Phase 1: Core Infrastructure
1. Create new directory structure
2. Migrate basic configuration (options, keymaps)
3. Setup lazy.nvim bootstrap

### Phase 2: Essential Plugins
1. Migrate UI plugins (nvim-tree, which-key)
2. Setup LSP infrastructure (mason, lspconfig)
3. Basic editing enhancements

### Phase 3: Advanced Features  
1. Migrate complex plugins (treesitter, lualine)
2. Setup git integration
3. Fine-tune lazy loading

### Phase 4: Optimization
1. Performance testing
2. Configuration cleanup
3. Documentation updates

---

*This architecture provides a solid foundation for a modern, maintainable, and performant Neovim configuration using lazy.nvim and contemporary Lua patterns.*