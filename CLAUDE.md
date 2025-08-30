# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Nix-based system configuration repository that manages macOS systems using nix-darwin and home-manager. The repository uses Nix flakes and provides a unified interface through a Python-based CLI tool called `sysdo`.

## Architecture

### Core Components

- **Flake Structure**: `flake.nix` (lines 1-120+) defines three main output types:
  - `darwinConfigurations` (lines 36-45): System-level macOS configurations via nix-darwin
  - `homeConfigurations` (lines 46-55): User-level configurations via home-manager  
  - `packages` and `apps` (lines 56-80): Custom packages and applications (sysdo, cb utilities)

- **Configuration Modules**:

  **`system/darwin/`** - macOS system-level configurations:
  - `default.nix` (lines 8-16): Imports nix-homebrew, home-manager, common config, preferences, and brew
  - `preferences.nix`: macOS system preferences (dock, finder, trackpad, etc.)
  - `brew.nix`: Homebrew packages and casks managed via nix-homebrew
  - `wm.nix`: Window management configurations (Aerospace, etc.)

  **`system/home-manager/`** - User environment configurations:
  - `default.nix` (lines 169-264): Main configuration with tmux (lines 169-264), starship (lines 124-146), fzf (lines 94-122), packages list (lines 309-385), and dotfile symlinks (lines 387-405)
  - `zsh.nix`: Zsh shell configuration with plugins and aliases
  - `git.nix`: Git configuration with aliases and settings
  - `nvim/default.nix`: Neovim configuration and plugins
  - `alacritty.nix`: Terminal emulator configuration
  - `1password.nix`: 1Password CLI integration
  - `direnv.nix`: Directory environment management
  - `aliases.nix`: Shell aliases and functions

  **`system/lib/`** - Helper functions:
  - `helpers.nix`: Functions for creating darwin and home-manager configurations
  - `default.nix`: Library exports and utilities

  **`system/`** - Shared configurations:
  - `common.nix`: Shared configuration imported by darwin systems
  - `nixpkgs.nix`: Nixpkgs configuration and overlays
  - `fonts.nix`: Font configurations
  - `overlays/neovim.nix`: Custom Neovim overlay with nightly builds

  **`dotfiles/`** - Raw configuration files symlinked into place:
  - `config/nvim/`: Neovim Lua configurations
  - `config/tmux/`: Tmux configuration files (tmux.conf, tmux.remote.conf)
  - `config/aerospace/`: Aerospace window manager config
  - `config/karabiner/`: Karabiner key remapping configurations
  - `config/tmuxinator/`: Tmux session management templates
  - `hammerspoon/`: Hammerspoon Lua automation scripts

  **`bin/`** - CLI utilities:
  - `do.py`: Primary sysdo CLI tool for system management operations

### Key Files

- `flake.nix`: Main flake definition with inputs, outputs, and configuration generation
- `bin/do.py`: Primary CLI tool for system management operations  
- `system/lib/helpers.nix`: Functions for creating darwin and home-manager configurations
- `system/common.nix`: Shared configuration imported by darwin systems
- `system/home-manager/default.nix`: Main home-manager configuration with program settings

## Essential Commands

### System Management (via sysdo)

The primary interface is through the `sysdo` command (implemented in `bin/do.py`):

```bash
# Build configuration without applying
nix run .#sysdo build [melchior@aarch64-darwin]

# Apply configuration changes
nix run .#sysdo switch [melchior@aarch64-darwin]

# Bootstrap new system (first-time setup)
nix run .#sysdo bootstrap [melchior@aarch64-darwin]

# Update flake inputs
nix run .#sysdo update [--flake input-name]

# Garbage collection
nix run .#sysdo gc --delete-older-than 30d

# Clean build artifacts
nix run .#sysdo clean
```

### Development Commands

```bash
# Enter development shell with pre-commit hooks
nix develop

# Format Nix code
nix fmt

# Run pre-commit checks
nix flake check

# Build specific outputs
nix build .#darwinConfigurations.melchior@aarch64-darwin.config.system.build.toplevel
nix build .#homeConfigurations.melchior@aarch64-darwin.activationPackage
```

### Direct Platform Commands

When `sysdo` is not available:

```bash
# Darwin system rebuild
sudo darwin-rebuild switch --flake .#melchior@aarch64-darwin

# Home-manager rebuild  
home-manager switch --flake .#melchior@aarch64-darwin
```

## Configuration Patterns

### Adding New Programs

1. **Home-manager programs**: Add to `system/home-manager/default.nix` in the `programs` section
2. **System packages**: Add to the `packages` list in `system/home-manager/default.nix`
3. **Darwin system settings**: Add to `system/darwin/` modules

### Dotfiles Management

- Raw config files: Place in `dotfiles/config/` 
- Symlinked via: `home.file` entries in `system/home-manager/default.nix`
- Dynamic configs: Generated directly in Nix configuration

### Pre-commit Hooks

Enabled hooks (defined in `flake.nix`):
- `black`: Python formatting
- `shellcheck`: Shell script linting  
- `alejandra`: Nix formatting
- `stylua`: Lua formatting
- `deadnix`: Dead Nix code removal

## Host Configuration

Current configured host: `melchior@aarch64-darwin` (ARM64 macOS system)

The system automatically detects platform and username, but can be overridden with explicit host specifications in commands.

## Key Integrations

- **Aura theming**: Applied across multiple applications (nvim, tmux) with Aura color palette (`#15141b` black background)
- **Homebrew**: Managed via `nix-homebrew` in `system/darwin/brew.nix`
- **Pre-commit hooks**: Integrated into development shell and CI checks (defined in `flake.nix`)
- **Neovim**: Custom overlay with nightly builds in `system/overlays/neovim.nix`
- **Tmux**: Custom Aura theme configuration in `system/home-manager/default.nix` (lines 184-252)
- **Dotfiles syminking**: Raw configs in `dotfiles/` symlinked via `home.file` entries