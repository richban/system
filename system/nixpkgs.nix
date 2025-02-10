{
  config,
  inputs,
  self,
  ...
}: {
  nixpkgs = {
    config   = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
      allowBroken = false;
    };
  };

  nix = {
    # Enable flakes.
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    # Garbage collection.
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    settings = {
      max-jobs      = 8;
      trusted-users = ["${config.user.name}" "root" "@admin" "@sudo" "@wheel"];
      # Optionally add trusted-substituters and trusted-public-keys:
      # trusted-substituters = [
      #   "https://cache.nixos.org"
      #   "https://nix-community.cachix.org"
      #   "https://richban.cachix.org"
      # ];
      # trusted-public-keys = [
      #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "richban.cachix.org-1:b22iBPRwWfvVe1ldyn3ca1JRw0OEzzf3jrurGJQN3LA="
      # ];
    };

    registry = {
      home-manager.flake = inputs.home-manager;
    };
  };
}
