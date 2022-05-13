{
  description = "NixOS systems and tools by richban";

  inputs = {
    # We use the unstable nixpkgs repo for some packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    
    # TODO: configure NixOS
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";

    # Darwin system management
    darwin = {
      url = "github:kclejeune/nix-darwin/backup-etc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other packages
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    comma = { url = github:Shopify/comma; flake = false; };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
  let
      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfig;
      inherit (builtins) listToAttrs map;

      isDarwin = system: (builtins.elem system nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # Overlays is the list of overlays we want to apply from flake inputs.
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];

      mkDarwinConfig = {
        system ? "x86_64-darwin",
        nixpkgs ? inputs.nixpkgs,
        stable ? inputs.nixos-stable,
        baseModules ? [home-manager.darwinModules.home-manager ./darwin],
        extraModules ? []
      }: 
      darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules ++ [{ nixpkgs.overlays = overlays; }];
        specialArgs = { inherit inputs nixpkgs stable; };
      };

      mkHomeManagerConfig = {
        username,
        system ? "x86_64-darwin",
        nixpkgs ? inputs.nixpkgs,
        stable ? inputs.nixos-stable,
        baseModules ? [
            ./home-manager
            {
              home.sessionVariables = {
                NIX_PATH =
                  "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
              };
            }
        ],
        extraModules ? []
      }:
      homeManagerConfig rec {
        inherit system username;
        homeDirectory = "${homePrefix system}/${username}";
        extraSpecialArgs = { inherit inputs nixpkgs stable; };
        configuration = {
          imports = baseModules ++ extraModules ++ [{ nixpkgs.overlays = overlays; }];
        };
      };
  in {

    # checks = listToAttrs (
    #   # darwin checks
    #   (map
    #     (system: {
    #       name = system;
    #       value = {
    #         darwin =
    #           self.darwinConfigs.casper-03.config.system.build.toplevel;
    #       };
    #     })
    #     nixpkgs.lib.platforms.darwin)
    # );

    darwinConfigs = {
      casper-03 = mkDarwinConfig {};
    };

    homeManagerConfigs = {
      casper-03 = mkHomeManagerConfig {
        username = "richban";
        system = "x86_64-darwin";
      };
    };
  };
}
