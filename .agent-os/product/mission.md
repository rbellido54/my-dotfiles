# Product Mission

> Last Updated: 2025-07-22
> Version: 1.0.0

## Pitch

my-dotfiles is a comprehensive, modern, cross-platform development environment configuration that helps software developers and DevOps engineers achieve consistent, efficient workflows across macOS and Linux by providing a streamlined setup with Neovim, Zsh, and integrated development tools.

## Users

### Primary Customers

- **Cross-platform Developers**: Professionals working across macOS and Linux environments who need consistent tooling
- **DevOps Engineers**: System administrators requiring standardized development environments

### User Personas

**Senior Full-Stack Developer** (28-45 years old)
- **Role:** Lead Developer / Senior Engineer
- **Context:** Works on multiple projects, switches between macOS and Linux environments regularly
- **Pain Points:** Time lost configuring development environments, inconsistent tool behavior across platforms, maintaining custom configurations
- **Goals:** Streamlined setup process, consistent development experience, modern tooling that boosts productivity

**DevOps Engineer** (25-40 years old)
- **Role:** Site Reliability Engineer / Infrastructure Engineer
- **Context:** Manages multiple servers and development environments, needs reliable and repeatable setups
- **Pain Points:** Manual environment configuration, outdated tooling, difficulty maintaining configurations across team members
- **Goals:** Automated setup processes, standardized team environments, efficient terminal-based workflows

## The Problem

### Fragmented Development Environment Setup

Setting up a consistent, modern development environment across different operating systems is time-consuming and error-prone. Developers spend hours configuring editors, shells, and tools, often ending up with inconsistent setups that impact productivity.

**Our Solution:** Provide a one-command installation that creates a complete, modern development environment with Neovim, Zsh, and essential development tools.

### Legacy Configuration Management

Many developers are stuck with outdated VimScript configurations and legacy plugin management systems that don't leverage modern Neovim capabilities and Lua-based configuration.

**Our Solution:** Migrate to modern Lua-based Neovim configuration with LazyVim-style plugin management while maintaining compatibility and ease of use.

### Cross-Platform Compatibility Challenges

Maintaining development environment configurations that work seamlessly across macOS and Linux requires constant tweaking and platform-specific workarounds.

**Our Solution:** Build configurations that intelligently adapt to the target platform while providing consistent functionality and user experience.

## Differentiators

### Modern Lua-First Approach

Unlike traditional vim configurations that rely heavily on VimScript, we provide a modern Lua-based Neovim setup that leverages the latest features and performance improvements. This results in faster startup times and more maintainable configuration.

### Comprehensive Tool Integration

Unlike basic dotfiles repositories that focus only on shell configuration, we provide complete integration of development tools including language servers, formatters, linters, git tools, and terminal enhancements. This results in a cohesive development environment out of the box.

### Cross-Platform Intelligence

Unlike platform-specific configurations, we provide intelligent detection and adaptation for both macOS and Linux environments while maintaining feature parity. This results in truly portable development environments.

## Key Features

### Core Features

- **One-Command Installation:** Complete environment setup with `make apply-all`
- **Modern Neovim Configuration:** Lua-based configuration with LSP, formatting, and linting
- **Intelligent Shell Setup:** Zsh with Oh My Zsh, Starship prompt, and modular configuration
- **Package Management Integration:** Homebrew for macOS with cross-platform alternatives

### Development Features

- **Language Runtime Management:** mise integration for Node.js, Python, Ruby, Go, and Rust
- **Git Workflow Enhancement:** lazygit, git-delta, and fugitive integration
- **File Navigation Tools:** fzf, ripgrep, yazi file manager, and nvim-tree
- **Terminal Enhancement:** Syntax highlighting, autosuggestions, and fuzzy finding

### Collaboration Features

- **Modular Configuration:** Easily customizable components without breaking core functionality
- **Version Control Integration:** All configurations tracked in git with symlink-based installation