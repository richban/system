{
  description = "NixOS systems and tools by richban";

  nixConfig = {
    # substituters = [
    #   "https://cache.nixos.org"
    #   "https://nix-community.cachix.org"
    #   "https://richban.cachix.org"
    # ];
    #
    # trusted-public-keys = [
    #   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    #   "richban.cachix.org-1:b22iBPRwWfvVe1ldyn3ca1JRw0OEzzf3jrurGJQN3LA="
    # ];
  };

  inputs = {
    # We use the unstable nixpkgs repo for some packages.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    # nixos-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # comma = { url = github:Shopify/comma; flake = false; };
    # spacebar.url = "github:cmacrae/spacebar/v1.4.0";
    flake-utils.url = "github:numtide/flake-utils";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devenv = {
      url = "github:cachix/devenv/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # devshell = {
    #   url = "github:numtide/devshell";
    #   inputs.flake-utils.follows = "flake-utils";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    flake-utils,
    devenv,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (flake-utils.lib) eachSystemMap defaultSystems;

    isDarwin = system: (builtins.elem system nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";

    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      (final: prev: {
        vimPlugins =
          prev.vimPlugins
          // {
            projections = prev.vimUtils.buildVimPlugin {
              name = "projections";
              src = inputs.projections;
            };
            nui = prev.vimUtils.buildVimPlugin {
              name = "nui";
              src = inputs.nui;
            };
            incRename = prev.vimUtils.buildVimPlugin {
              name = "inc-rename";
              src = inputs.incRename;
            };
            diffview = prev.vimUtils.buildVimPlugin {
              name = "diffview";
              src = inputs.diffview;
            };
            oxacarbonColors = prev.vimUtils.buildVimPlugin {
              name = "oxacarbon-colors";
              src = inputs.oxacarbonColors;
            };
            copilot = prev.vimUtils.buildVimPlugin {
              name = "copilot";
              src = inputs.copilot;
            };
            copilotCmp = prev.vimUtils.buildVimPlugin {
              name = "copilot-cmp";
              src = inputs.copilotCmp;
            };
            copilotLualine = prev.vimUtils.buildVimPlugin {
              name = "copilot-lualine";
              src = inputs.copilotLualine;
            };
            copilotChat = prev.vimUtils.buildVimPlugin {
              name = "CopilotChat.nvim";
              src = inputs.copilotChat;
            };
            conformNvim = prev.vimUtils.buildVimPlugin {
              name = "conform.nvim";
              src = inputs.conformNvim;
            };
            ropeVim = prev.vimUtils.buildVimPlugin {
              name = "ropevim";
              src = inputs.ropeVim;
            };
          };
      })
    ];

    # generate a darwin config
    mkDarwinConfig = {
      system ? "x86_64-darwin",
      nixpkgs ? inputs.nixpkgs,
      baseModules ? [home-manager.darwinModules.home-manager ./system/darwin],
      extraModules ? [],
    }:
      darwinSystem {
        inherit system;
        modules = baseModules ++ extraModules ++ [{nixpkgs.overlays = overlays;}];
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
        pkgs = import nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
        extraSpecialArgs = {inherit self inputs nixpkgs;};
        modules = {
          # imports = baseModules ++ extraModules ++ [ ./system/overlays.nix ];
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
    };

    devShells = eachSystemMap defaultSystems (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in {
      default = devenv.lib.mkShell {
        inherit inputs pkgs;
        modules = [
          (import ./devenv.nix)
          # {
          #   enterShell = ''
          #     export PATH=$PATH:${pkgs.sysdo}/bin/
          #   '';
          # }
        ];
      };
    });

    packages = eachSystemMap defaultSystems (
      system: let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues self.overlays;
        };
      in rec {
        pyEnv =
          pkgs.python3.withPackages
          (ps: with ps; [black typer colorama shellingham]);
        sysdo = pkgs.writeScriptBin "sysdo" ''
          #! ${pyEnv}/bin/python3
          ${builtins.readFile ./bin/do.py}
        '';
        gitmanager = pkgs.writeScriptBin "gitmanager" ''
          #! ${pyEnv}/bin/python3
          ${builtins.readFile ./bin/git_manager.py}
        '';
        obsidianbackup = pkgs.writeScriptBin "obsidianbackup" ''
          #! ${pyEnv}/bin/python3
          ${builtins.readFile ./bin/obsidian_backup.py}
        '';
      }
    );

    apps = eachSystemMap defaultSystems (system: rec {
      sysdo = {
        type = "app";
        program = "${self.packages.${system}.sysdo}/bin/sysdo";
      };
      gitmanager = {
        type = "app";
        program = "${self.packages.${system}.gitmanager}/bin/gitmanager";
      };
      obsidianbackup = {
        type = "app";
        program = "${self.packages.${system}.obsidianbackup}/bin/obsidianbackup";
      };
      default = sysdo;
    });

    overlays = {
      channels = final: prev: {
        # expose other channels via overlays
        unstable = import inputs.unstable {inherit (prev) system;};
      };
      extraPackages = final: prev: let
        pkgs = final;
      in
        with pkgs; {
          inherit (self.packages.${prev.system}) sysdo;
          inherit (self.packages.${prev.system}) pyEnv;
          inherit (self.packages.${prev.system}) gitmanager;
          inherit (self.packages.${prev.system}) obsidianbackup;
          inherit (self.packages.${prev.system}) devenv;
        };
    };
  };
}
