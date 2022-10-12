{
  description = "NixOS systems and tools by richban";

  # FIX: when used it's very slow
  nixConfig = {
    substituters = [
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

  inputs = {
    # We use the unstable nixpkgs repo for some packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # TODO: configure NixOS
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Darwin system management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other packages
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # comma = { url = github:Shopify/comma; flake = false; };
    # spacebar.url = "github:cmacrae/spacebar/v1.4.0";
    flake-utils.url = "github:numtide/flake-utils";
    devshell = {
      url = "github:numtide/devshell";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@ { self, nixpkgs, darwin, home-manager, flake-utils, ... }:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (flake-utils.lib) eachSystemMap defaultSystems;
      inherit (builtins) listToAttrs map;

      isDarwin = system: (builtins.elem system nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # Overlays is the list of overlays we want to apply from flake inputs.
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        # inputs.spacebar
      ];

      # generate a darwin config
      mkDarwinConfig =
        { system ? "x86_64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.nixos-stable
        , baseModules ? [ home-manager.darwinModules.home-manager ./system/darwin ]
        , extraModules ? [ ]
        }:
        darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules ++ [{ nixpkgs.overlays = overlays; }];
          specialArgs = { inherit self inputs nixpkgs stable; };
        };

      # generate a home-manager config for any unix system
      mkHomeConfig =
        { username
        , system ? "aarch64-darwinn"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.nixos-stable
        , baseModules ? [
            ./system/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
                sessionVariables = {
                  NIX_PATH =
                    "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
                };
                # stateVersion = "22.05";
              };
            }
          ]
        , extraModules ? [ ]
        }:
        homeManagerConfiguration rec {
          pkgs = import nixpkgs {
            inherit system;
          };
          extraSpecialArgs = { inherit self inputs nixpkgs stable; };
          modules = {
            imports = baseModules ++ extraModules ++ [ ./system/overlays.nix ];
          };
        };
    in
    {

      darwinConfigurations = {
        darwinCasperIntel = mkDarwinConfig {
          system = "x86_64-darwin";
          extraModules = [ ./system/hosts/personal.nix ];
        };
        darwinWorkM1 = mkDarwinConfig {
          system = "aarch64-darwin";
          extraModules = [ ./system/hosts/work.nix ];
        };
      };

      homeConfigurations = {
        richbanIntel = mkHomeConfig {
          username = "richban";
          system = "x86_64-darwin";
        };
        richbanWorkM1 = mkHomeConfig {
          username = "richard_banyi";
          system = "aarch64-darwin";
          extraModules = [ ./system/hosts/work.nix ];
        };
      };

      # add a devShell to this flake
      devShells = eachSystemMap defaultSystems (system:
        let
          pkgs = import inputs.nixos-stable {
            inherit system;
            overlays = [ inputs.devshell.overlay ];
          };
          pyEnv = (pkgs.python3.withPackages
            (ps: with ps; [ black pylint typer colorama shellingham ]));
          sysdo = pkgs.writeShellScriptBin "sysdo" ''
            cd $PRJ_ROOT && ${pyEnv}/bin/python3 bin/do.py $@
          '';
        in
        {
          default = pkgs.devshell.mkShell {
            packages = with pkgs; [ nixfmt pyEnv rnix-lsp stylua treefmt nodePackages.prettier ];
            commands = [{
              name = "sysdo";
              package = sysdo;
              category = "utilities";
              help = "perform actions on this repository";
            }];
          };
        }
      );
    };
}
