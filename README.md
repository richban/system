<h1 align="center">
    <code>Nix System Config & dotfiles</code>
</h1>

This repository manages system configurations for all of my OSX based machines.
The system configurations are defined as a [flake.nix](https://nixos.wiki/wiki/Flakes).

## 🧠 Philosophy

- `nix-darwin` and `home-manager` configurations are decoupled. Meaning both can be used independently.
- `home-manager` can be (is) used as a module within `nix-darwin`. See `common.nix` file.

```nix
  # bootstrap home-manager
  hm = import ./home-manager;
```

- `home-manager` is fully compatible as a standalone configuration, managed with the `home-manager` CLI - this requires [standalone installation](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).
- flake outputs define platform specific `darwinConfigurations` and home profile specific configurations `homeConfigurations`.

## ⚙️ Installation

Run the installer script to perform a multi-user installation. The installer also installs `nix-darwin`, since it doesn't work with flakes out of the box.

```
./bin/install_nix.sh
```

## 🚀 Bootstrapping

### Darwin

Clone this repository into `~/Developer`:

```bash
git@github.com:richban/dotfiles.git
```

Bootstrap a `nix-darwin` system using:

```bash
nix --extra-experimental-features "nix-command flakes" develop -c sysdo bootstrap --darwin
```

Bootstrap a `home-manager` configuration using:

```bash
nix --extra-experimental-features "nix-command flakes" develop -c sysdo bootstrap --home-manager
```
