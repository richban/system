{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./pam.nix
    ./brew.nix
    ./configuration.nix
  ];
}

