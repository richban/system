{
  description = "NixOS systems and tools by richban";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0";
    nixpkgs.url = "https://flakehub.com/f/nixos/nixpkgs/0.2411.*";
    nixpkgs-unstable.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    devenv = {
      url = "github:cachix/devenv/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Neovim flakes
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    projections = { url = "github:gnikdroy/projections.nvim/pre_release"; flake = false; };
    nui = { url = "github:MunifTanjim/nui.nvim"; flake = false; };
    incRename = { url = "github:smjonas/inc-rename.nvim"; flake = false; };
    diffview = { url = "github:sindrets/diffview.nvim"; flake = false; };
    oxacarbonColors = { url = "github:nyoom-engineering/oxocarbon.nvim"; flake = false; };
    copilot = { url = "github:zbirenbaum/copilot.lua"; flake = false; };
    copilotCmp = { url = "github:zbirenbaum/copilot-cmp"; flake = false; };
    copilotLualine = { url = "github:AndreM222/copilot-lualine"; flake = false; };
    copilotChat = { url = "github:CopilotC-Nvim/CopilotChat.nvim"; flake = false; };
    conformNvim = { url = "github:stevearc/conform.nvim"; flake = false; };
    ropeVim = { url = "github:python-rope/ropevim"; flake = false; };
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    ...
  } @ inputs: let
    inherit (inputs.nix-darwin.lib) darwinSystem;
    inherit (inputs.home-manager.lib) homeManagerConfiguration;
    inherit (inputs.nixpkgs) lib;
    inherit (lib) attrValues elem filterAttrs genAttrs intersectLists map mapAttrs mapAttrs' mapAttrsToList mergeAttrsList nameValuePair platforms;

    stateVersion = "24.11";
    helper = import ./system/lib { inherit inputs self stateVersion; };

    defaultSystems =
      intersectLists
      (platforms.linux ++ platforms.darwin)
      (platforms.x86_64 ++ platforms.aarch64);
    darwinSystems = intersectLists defaultSystems platforms.darwin;
    linuxSystems = intersectLists defaultSystems platforms.linux;
    eachSystemMap = genAttrs;

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

  in {
    checks = mergeAttrsList [
      # verify devShell + pre-commit hooks;
      (eachSystemMap defaultSystems (
        system: {
          devShell = self.devShells.${system}.default;
          pre-commit-check = mkHooks system;
        }
      ))
      # home-manager checks; add _home suffix to original config to avoid nixos coflict
      (eachSystemMap defaultSystems (system:
        mapAttrs'
        (name: drv: (nameValuePair "${name}_home" drv.activationPackage))
        (filterAttrs
          (name: drv: lib.strings.hasSuffix system name)
          self.homeConfigurations)))
      # darwin checks; limit these to darwinSystems
      (eachSystemMap darwinSystems (system:
        mapAttrs
        (name: drv: drv.config.system.build.toplevel)
        (filterAttrs
          (name: drv: lib.strings.hasSuffix system name)
          self.darwinConfigurations)))
    ];

    darwinConfigurations = {
      "melchior@aarch64-darwin" = helper.mkDarwin {
        hostname = "mac-mini";
        username = "melchior";
        platform = "aarch64-darwin";
      };
    };

    homeConfigurations = {
      "melchior@aarch64-darwin" = helper.mkHome {
        hostname = "mac-mini";
        username = "melchior";
        platform = "aarch64-darwin";
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
            bashInteractive  # Enhanced bash shell
            fd # Fast alternative to 'find'
            nixd # Nix language server
            ripgrep # Fast text search tool
            uv # Python packaging tool
          ]
          ++ (mapAttrsToList (name: value: value) self.packages.${system}); # Adds all packages defined in packages attribute
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
