# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive dotfiles repository for macOS development setup, featuring Neovim, Zsh with Oh My Zsh, terminal configurations, and development tools.

## Setup and Installation

### Primary Installation Command
```bash
make apply-all
```

This runs the complete installation process including:
- Pre-install script (oh-my-zsh plugins, mise installation)
- Symlinks all configuration files to home directory
- Post-install script (language versions via mise)

### Individual Components
```bash
make apply-nvim        # Neovim configuration
make apply-zshrc       # Zsh configuration
make apply-tmux        # Tmux configuration
make apply-starship    # Starship prompt
make apply-aliases     # Shell aliases
make apply-functions   # Shell functions
```

### Package Management
- **Homebrew packages**: Managed via `Brewfile` - run `brew bundle` to install
- **Oh My Zsh plugins**: Auto-installed via pre-install script
- **Languages**: Managed by mise (Node, Python, Ruby, Go, Rust)

## Architecture

### Neovim Configuration Structure
- **Entry point**: `nvim/init.vim` - sources all configuration modules
- **Plugin management**: vim-plug (auto-installs if missing)
- **Modular design**:
  - `vim-plug/plugins.vim`: Plugin definitions
  - `themes/`: Color scheme configurations (currently using nightfox)
  - `plug-config/`: Plugin-specific configurations
  - `keys/mappings.vim`: Key bindings
  - `lua/`: Modern Neovim Lua configurations including LSP

### Zsh Configuration
- **Main config**: `.zshrc` sources multiple specialized files
- **Modular structure**:
  - `.aliases.zsh`: Command aliases (vim->nvim, cat->bat, etc.)
  - `.functions.zsh`: Custom shell functions (tmux window management)
  - `.path-exports.zsh`: PATH modifications
  - `.envs.zsh`: Environment variables
  - `.fzf.zsh`: Fuzzy finder configuration

### Development Tools Stack
- **Editor**: Neovim with LSP, formatting (conform.nvim), linting (nvim-lint)
- **Terminal**: Supports Alacritty, Wezterm, and Ghostty
- **Shell**: Zsh with Oh My Zsh, Starship prompt
- **Multiplexer**: tmux configuration
- **Version Control**: Git with delta, lazygit integration
- **File Navigation**: fzf, ripgrep, yazi file manager
- **Languages**: Node.js, Python, Ruby, Go, Rust via mise

## Key Features

### Neovim Capabilities
- **LSP Integration**: Mason for language server management
- **Git Integration**: Fugitive, signify, lazygit
- **File Explorer**: nvim-tree
- **Fuzzy Finding**: fzf integration with vim-rooter
- **Code Completion**: GitHub Copilot
- **Theme Support**: 15+ themes available (nightfox active)
- **Formatting/Linting**: conform.nvim and nvim-lint

### Development Workflow
- **Package Installation**: Homebrew bundle for system packages
- **Language Management**: mise for runtime versions
- **Shell Enhancement**: Fast syntax highlighting, autosuggestions, autocomplete
- **Git Workflow**: Delta for diff viewing, lazygit for TUI

## Important Notes

- The repository assumes macOS environment (Darwin-specific configurations)
- Neovim configuration is plugin-heavy but modular
- Tmux window management includes custom swapping functions
- Starship prompt is enabled (Powerlevel10k is commented out)
- All configuration files are symlinked, not copied
- mise is used instead of rbenv/nvm for language management

## Agent OS Documentation

### Product Context
- **Mission & Vision:** @.agent-os/product/mission.md
- **Technical Architecture:** @.agent-os/product/tech-stack.md
- **Development Roadmap:** @.agent-os/product/roadmap.md
- **Decision History:** @.agent-os/product/decisions.md

### Development Standards
- **Code Style:** @~/.agent-os/standards/code-style.md
- **Best Practices:** @~/.agent-os/standards/best-practices.md

### Project Management
- **Active Specs:** @.agent-os/specs/
- **Spec Planning:** Use `@~/.agent-os/instructions/create-spec.md`
- **Tasks Execution:** Use `@~/.agent-os/instructions/execute-tasks.md`

## Workflow Instructions

When asked to work on this codebase:

1. **First**, check @.agent-os/product/roadmap.md for current priorities
2. **Then**, follow the appropriate instruction file:
   - For new features: @.agent-os/instructions/create-spec.md
   - For tasks execution: @.agent-os/instructions/execute-tasks.md
3. **Always**, adhere to the standards in the files listed above

## Important Notes

- Product-specific files in `.agent-os/product/` override any global standards
- User's specific instructions override (or amend) instructions found in `.agent-os/specs/...`
- Always adhere to established patterns, code style, and best practices documented above.