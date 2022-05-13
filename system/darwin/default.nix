{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./configuration.nix
  ];
}