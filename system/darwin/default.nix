{inputs, ...}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ../common.nix
    ./wm.nix
    ./core.nix
    ./preferences.nix
    ./brew.nix
  ];
}
