{ inputs, config, lib, pkgs, ... }: {
  nixpkgs = { config = import ./config.nix; };

  nix = {
    package = pkgs.nix;

    # Enable flakes
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';
    # Add administrators to trusted users
    trustedUsers = [ "richban" "root" "@admin" "@wheel" ];
    
    # Garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    maxJobs = 8;
    readOnlyStore = true;

    # Add inputs to registry & nix path
    nixPath = builtins.map
      (source: "${source}=/etc/${config.environment.etc.${source}.target}") [
      "home-manager"
      "nixpkgs"
      "stable"
    ];

    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = inputs.nixpkgs;
      };

      stable = {
        from = {
          id = "stable";
          type = "indirect";
        };
        flake = inputs.nixos-stable;
      };
    };
  };
}