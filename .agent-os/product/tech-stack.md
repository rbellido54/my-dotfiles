# Technical Stack

> Last Updated: 2025-07-22
> Version: 1.0.0

## Core Technologies

### Application Framework
- **Framework:** Shell scripts with Makefiles
- **Version:** POSIX-compatible with GNU Make
- **Language:** Bash/Zsh scripting

### Configuration Management
- **Primary:** Symlink-based file management
- **Version:** Git-tracked configurations
- **Approach:** Modular, source-based configuration files

## Development Stack

### Editor Framework
- **Framework:** Neovim
- **Version:** Latest stable (0.9+)
- **Configuration Language:** Lua (migrating from VimScript)

### Plugin Management
- **Current:** vim-plug
- **Target:** LazyVim / lazy.nvim
- **Package Count:** 100+ plugins

### Shell Framework
- **Shell:** Zsh
- **Framework:** Oh My Zsh
- **Prompt:** Starship
- **Version:** Latest stable

## Language & Runtime Management

### Version Manager
- **Tool:** mise (formerly rtx)
- **Supports:** Node.js, Python, Ruby, Go, Rust
- **Replaces:** nvm, rbenv, pyenv individual managers

### Supported Languages
- **Node.js:** 22 LTS
- **Python:** 3.11+
- **Ruby:** 3.2+
- **Go:** Latest stable
- **Rust:** Latest stable

## Development Tools

### Package Management
- **macOS:** Homebrew
- **Linux:** Native package managers (apt, pacman, etc.)
- **Definition:** Brewfile for reproducible installs

### Terminal Enhancements
- **File Search:** fzf, ripgrep
- **File Manager:** yazi
- **Git TUI:** lazygit
- **Diff Tool:** git-delta
- **Cat Alternative:** bat
- **Terminal Multiplexer:** tmux

### Terminal Emulators
- **Supported:** Alacritty, Wezterm, Ghostty
- **Configurations:** Provided for each emulator

## Code Quality Tools

### LSP Integration
- **Manager:** Mason
- **Servers:** Language-specific LSP servers
- **Formatting:** conform.nvim
- **Linting:** nvim-lint

### Git Integration
- **Core:** Git with enhanced configuration
- **TUI:** lazygit
- **Editor Integration:** fugitive, signify
- **Diff Enhancement:** delta

## Infrastructure

### Repository Hosting
- **Platform:** GitHub
- **Access:** Public repository
- **Installation:** Clone and symlink approach

### Cross-Platform Support
- **Primary:** macOS (Darwin)
- **Secondary:** Linux distributions
- **Detection:** OS-specific configuration blocks

### Installation Strategy
- **Method:** Symlink original files to home directory
- **Backup:** Automatic backup of existing configurations
- **Rollback:** Manual restoration from backups

## File Organization

### Configuration Structure
```
~/.config/nvim/          # Neovim configuration
~/.[config-name]         # Direct home directory configs
~/.local/bin/           # Custom scripts and binaries
```

### Theme Support
- **Neovim:** 15+ themes available (nightfox active)
- **Terminal:** Theme integration with prompt
- **Consistency:** Coordinated color schemes

## Deployment

### Installation Process
- **Step 1:** Clone repository
- **Step 2:** Run pre-install script (oh-my-zsh, mise)
- **Step 3:** Create symlinks with `make apply-all`
- **Step 4:** Run post-install script (language versions)

### Update Strategy
- **Method:** Git pull + re-run make targets
- **Rollback:** Git checkout previous commits
- **Customization:** Local overrides in separate files