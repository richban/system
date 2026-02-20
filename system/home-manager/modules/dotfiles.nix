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
    ".config/aerospace" = lib.mkIf pkgs.stdenv.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/aerospace";
    };

    ".hammerspoon" = lib.mkIf pkgs.stdenvNoCC.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/hammerspoon";
    };

    ".config/tmuxinator" = lib.mkIf pkgs.stdenv.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/tmuxinator";
    };

    ".config/karabiner" = lib.mkIf pkgs.stdenv.isDarwin {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/karabiner";
    };
  };
}
