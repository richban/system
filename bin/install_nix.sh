#! /usr/bin/env bash

URL="https://nixos.org/nix/install"

# install using workaround for darwin systems
if [[ $(uname -s) = "Darwin" ]]; then
    FLAG="--darwin-use-unencrypted-nix-store-volume"
fi

[[ -n "$1" ]] && URL="$1"

if command -v nix >/dev/null; then
    echo "nix is already installed on this system."
else
    bash <(curl -L "$URL") --daemon $FLAG
fi

NIX_CONF_PATH="$HOME/.config/nix"
mkdir -p "$NIX_CONF_PATH"

if [[ ! -f $NIX_CONF_PATH/nix.conf ]] || ! grep "experimental-features" <"$NIX_CONF_PATH"; then
    echo "experimental-features = nix-command flakes" | tee -a "$NIX_CONF_PATH"/nix.conf
fi

# Install if you want nix-darwin & home-manager CLI's
if ! grep -q nix-darwin ~/.nix-channels; then
  echo "https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin" >> ~/.nix-channels
fi
export NIX_PATH=darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH

if ! grep -q home-manager ~/.nix-channels; then
  echo "https://github.com/rycee/home-manager/archive/master.tar.gz home-manager" >> ~/.nix-channels
fi
export NIX_PATH=home-manager=$HOME/.nix-defexpr/channels/home-manager:$NIX_PATH

# Changing nix-darwin default config path to local git repo
export NIX_PATH=darwin-config=$HOME/Developer/dotfiles/system/darwin/default.nix:$NIX_PATH
echo $NIX_PATH

nix-channel --update

# install nix-darwin
sudo rm /etc/shells /etc/zprofile /etc/zshrc
nix-build '<darwin>' -A installer --out-link /tmp/nix-darwin && /tmp/nix-darwin/bin/darwin-installer

# courtesy of: https://github.com/burke/b
rm -rf /run/*
ln -shf /nix/store/$(ls /nix/store | grep darwin-system- | grep -v drv | head -1) /run/current-system

# /run/current-system/sw/bin/darwin-rebuild switch
