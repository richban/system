{
  config,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
    SKHD_PID_FILE = "/tmp/skhd_${config.home.username}.pid";
  };

  programs.zsh.shellAliases = lib.mkIf pkgs.stdenv.isDarwin (import ./darwin-aliases.nix {});

  home.file = {
    ".hammerspoon" = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/hammerspoon";
    };
  };

  xdg = {
    enable = true;
    configFile = {
      aerospace = lib.mkIf pkgs.stdenv.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/aerospace";
      };

      ghostty = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/ghostty";
      };

      tmuxinator = lib.mkIf pkgs.stdenv.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/tmuxinator";
      };

      karabiner = lib.mkIf pkgs.stdenv.isDarwin {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/karabiner";
      };
    };
  };
}
