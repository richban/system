{
  config,
  pkgs,
  ...
}: {
  nixpkgs = {config = import ./config.nix;};

  nix = {
    package = pkgs.nix;

    # Enable flakes
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    # Garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    settings = {
      max-jobs = 8;
      trusted-users = ["${config.user.name}" "root" "@admin" "@wheel"];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://richban.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "richban.cachix.org-1:b22iBPRwWfvVe1ldyn3ca1JRw0OEzzf3jrurGJQN3LA="
      ];
    };

    # Add inputs to registry & nix path
    nixPath =
      builtins.map
      (source: "${source}=/etc/${config.environment.etc.${source}.target}") [
        "home-manager"
        # "nixpkgs"
        # "stable"
      ];

    # registry = {
    #   nixpkgs = {
    #     from = {
    #       id = "nixpkgs";
    #       type = "indirect";
    #     };
    #     flake = inputs.nixpkgs;
    #   };
    #
    #   stable = {
    #     from = {
    #       id = "stable";
    #       type = "indirect";
    #     };
    #     flake = inputs.nixos-stable;
    #   };
    # };
  };
}
