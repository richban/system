{
  inputs,
  self,
  stateVersion,
  ...
}: {
  # Helper function for generating home-manager configs
  mkHome = {
    hostname,
    username ? "richban",
    platform ? "aarch64-darwin",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit
          inputs
          self
          hostname
          platform
          username
          stateVersion
          ;
      };
      modules = [../home-manager];
    };

  mkDarwin = {
    hostname,
    username ? "richban",
    platform ? "aarch64-darwin",
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
          ;
      };
      modules = [
        ../darwin
      ];
    };
}
