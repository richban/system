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

    spacebar.url = "github:cmacrae/spacebar/v1.4.0";

    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
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
        inputs.spacebar.overlay
      ];

      mkDarwinConfig = {
        system ? "x86_64-darwin",
        nixpkgs ? inputs.nixpkgs,
        stable ? inputs.nixos-stable,
        baseModules ? [home-manager.darwinModules.home-manager ./system/darwin],
        extraModules ? []
      }: 
      darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules ++ [{ nixpkgs.overlays = overlays; }];
        specialArgs = { inherit inputs nixpkgs stable; };
      };

      mkHomeConfig = {
        username,
        system ? "x86_64-darwin",
        nixpkgs ? inputs.nixpkgs,
        stable ? inputs.nixos-stable,
        baseModules ? [
            ./system/home-manager
            {
              home.sessionVariables = {
                NIX_PATH =
                  "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
              };
            }
        ],
        extraModules ? []
      }:
      homeManagerConfiguration rec {
        inherit system username;
        homeDirectory = "${homePrefix system}/${username}";
        extraSpecialArgs = { inherit inputs nixpkgs stable; };
        configuration = {
          imports = baseModules ++ extraModules ++ [ ./system/overlays.nix];
          # NOTE: Here we are injecting colorscheme so that it is passed down all the imports
          _module.args = {
            colorscheme = (import ./system/colorschemes/dracula.nix);
          };
        };
      };
  in {

    # TODO: what are these checks?
    checks = listToAttrs (
      # darwin checks
      (map
        (system: {
          name = system;
          value = {
            darwin =
              self.darwinConfigurations.casper-03.config.system.build.toplevel;
          };
        })
        nixpkgs.lib.platforms.darwin)
    );

    darwinConfigurations = {
      casper-03 = mkDarwinConfig {
        system = "x86_64-darwin";
      };
    };

    homeConfigurations = {
      casper-03 = mkHomeConfig {
        username = "richban";
        system = "x86_64-darwin";
      };
    };

    # add a devShell to this flake
    devShells = eachSystemMap defaultSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ inputs.devshell.overlay ];
        };
        pyEnv = (pkgs.python3.withPackages
          (ps: with ps; [ black pylint typer colorama shellingham]));
        sysdo = pkgs.writeShellScriptBin "sysdo" ''
          cd $PRJ_ROOT && ${pyEnv}/bin/python3 bin/do.py $@
        '';
      in
      {
        default = pkgs.devshell.mkShell {
          packages = with pkgs; [ nixfmt pyEnv rnix-lsp stylua treefmt nodePackages.prettier];
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
