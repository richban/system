{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./pam.nix
    ./wm.nix
    ./configuration.nix
  ];
}

