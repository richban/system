{
  description = "NixOS systems and tools by richban";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0";
    nixpkgs.url = "https://flakehub.com/f/nixos/nixpkgs/0.2411.*";
    nixpkgs-unstable.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0";
    
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    projections = {
      url = "github:gnikdroy/projections.nvim/pre_release";
      flake = false;
    };
    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    incRename = {
      url = "github:smjonas/inc-rename.nvim";
      flake = false;
    };
    diffview = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };
    oxacarbonColors = {
      url = "github:nyoom-engineering/oxocarbon.nvim";
      flake = false;
    };
    copilot = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };
    copilotCmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };
    copilotLualine = {
      url = "github:AndreM222/copilot-lualine";
      flake = false;
    };
    copilotChat = {
      url = "github:CopilotC-Nvim/CopilotChat.nvim";
      flake = false;
    };
    conformNvim = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    ropeVim = {
      url = "github:python-rope/ropevim";
      flake = false;
    };

    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devenv = {
      url = "github:cachix/devenv/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    determinate,
    home-manager,
    flake-utils,
    devenv,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (flake-utils.lib) eachSystemMap defaultSystems;
    inherit (inputs.nixpkgs) lib;
    inherit (lib) mapAttrsToList;

    isDarwin = system: (builtins.elem system nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";

    mkHooks = system:
      inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          black.enable = true;
          shellcheck.enable = true;
          alejandra.enable = true;
          shfmt.enable = false;
          stylua.enable = true;
          deadnix = {
            enable = true;
            settings = {
              edit = true;
              noLambdaArg = true;
            };
          };
        };
      };

    # generate a darwin config
    mkDarwinConfig = {
      system ? "x86_64-darwin",
      nixpkgs ? inputs.nixpkgs,
      baseModules ? [determinate.darwinModules.default home-manager.darwinModules.home-manager ./system/darwin],
      extraModules ? [],
    }:
      darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules;
        specialArgs = {inherit self inputs nixpkgs;};
      };

    # generate a home-manager config for any unix system
    mkHomeConfig = {
      username,
      system ? "aarch64-darwin",
      nixpkgs ? inputs.nixpkgs,
      baseModules ? [
        ./system/home-manager
        {
          home = {
            inherit username;
            homeDirectory = "${homePrefix system}/${username}";
            sessionVariables = {
              NIX_PATH = "nixpkgs=${nixpkgs}";
            };
          };
        }
      ],
      extraModules ? [],
    }:
      homeManagerConfiguration rec {
        pkgs = nixpkgs;
        extraSpecialArgs = {inherit self inputs nixpkgs;};
        modules = {
          imports = baseModules ++ extraModules;
        };
      };

    mkChecks = {
      arch,
      os,
      username ? "richban",
    }: {
      "${arch}-${os}" = {
        "${username}_${os}" =
          (
            if os == "darwin"
            then self.darwinConfigurations
            else self.nixosConfigurations
          )
          ."${username}@${arch}-${os}"
          .config
          .system
          .build
          .toplevel;
        # "${username}_home" =
        #   self.homeConfigurations."${username}@${arch}-${os}".activationPackage;
        devShell = self.devShells."${arch}-${os}".default;
      };
    };
  in {
    checks =
      {}
      // (mkChecks {
        arch = "aarch64";
        os = "darwin";
        username = "richard_banyi";
      })
      // (mkChecks {
        arch = "x86_64";
        os = "darwin";
      })
      // (mkChecks {
        arch = "aarch64";
        os = "darwin";
        username = "melchior";
      });

    darwinConfigurations = {
      "richban@x86_64-darwin" = mkDarwinConfig {
        system = "x86_64-darwin";
        extraModules = [./system/hosts/personal.nix];
      };
      "richard_banyi@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./system/hosts/work.nix];
      };
      "richban@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./system/hosts/work_m2.nix];
      };
      "melchior@aarch64-darwin" = mkDarwinConfig {
        system = "aarch64-darwin";
        extraModules = [./system/hosts/mac_mini.nix];
      };
    };

    homeConfigurations = {
      "richban@x86_64-darwin" = mkHomeConfig {
        username = "richban";
        system = "x86_64-darwin";
      };
      "richard_banyi@aarch64-darwin" = mkHomeConfig {
        username = "richard_banyi";
        system = "aarch64-darwin";
        extraModules = [./system/hosts/work.nix];
      };
      "richban@aarch64-darwin" = mkHomeConfig {
        username = "richard.banyi";
        system = "aarch64-darwin";
        extraModules = [./system/hosts/work_m2.nix];
      };
      "melchior@aarch64-darwin" = mkHomeConfig {
        username = "melchior";
        system = "aarch64-darwin";
        extraModules = [./system/hosts/mac_mini.nix];
      };
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
      pre-commit-check = mkHooks system;
    in {
      default = pkgs.mkShell {
        inherit (pre-commit-check) shellHook;
        packages = with pkgs;
          [
            bashInteractive
            fd
            nixd
            ripgrep
            uv
          ]
          ++ (mapAttrsToList (name: value: value) self.packages.${system});
        inputsFrom = pre-commit-check.enabledPackages;
      };
    });

    packages = eachSystemMap defaultSystems (
      system: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
      in rec {
        sysdo = pkgs.writeShellScriptBin "sysdo" "${pkgs.uv}/bin/uv run -q ${./bin/do.py} $@";
      }
    );

    apps = eachSystemMap defaultSystems (system: rec {
      sysdo = {
        type = "app";
        program = "${self.packages.${system}.sysdo}/bin/sysdo";
      };
      default = sysdo;
    });

    overlays = {
      neovimOverlay = import ./system/overlays/neovim.nix { inherit inputs; };
      default = final: prev: {
        sysdo = self.packages.${prev.system}.sysdo;
      };
    };
  };
}
