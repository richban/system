{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./pam.nix
    ./configuration.nix
  ];
}

