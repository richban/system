{
  inputs,
  self,
  stateVersion,
  ...
}: {
  mkHome = {
    hostname,
    username ? "richban",
    platform ? "aarch64-darwin",
    flakeRoot ? ".nixpkgs",
    baseModules ? [
      ../home-manager
    ],
    extraModules ? [],
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = platform;
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
        overlays = [
          self.overlays.neovimOverlay
          self.overlays.default
        ];
      };
      extraSpecialArgs = {
        inherit
          inputs
          self
          hostname
          platform
          username
          stateVersion
          flakeRoot
          ;
      };
      modules = baseModules ++ extraModules;
    };

  mkDarwin = {
    hostname,
    username ? "richban",
    platform ? "aarch64-darwin",
    flakeRoot ? ".nixpkgs",
    homeModules ? [],
  }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit
          inputs
          self
          hostname
          platform
          username
          stateVersion
          homeModules
          flakeRoot
          ;
      };
      modules = [
        ../darwin
      ];
    };
}
