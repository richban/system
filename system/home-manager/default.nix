{ inputs, config, pkgs, lib, ... }:
let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in {
  imports = [./zsh.nix ./alacritty.nix ./git.nix ];

  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/${relativeXDGConfigPath}";
    dataHome = "${config.home.homeDirectory}/${relativeXDGDataPath}";
    cacheHome = "${config.home.homeDirectory}/${relativeXDGCachePath}";
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/Developer/dotfiles/system/home-manager";
  };

  programs.bat.enable = true;
  programs.fzf = {
    enable = true;
    fileWidgetOptions = [
      # Preview the contents of the selected file - CTRL+T
      "--preview 'bat --color=always --plain {}'"
    ];

    changeDirWidgetOptions = [
      # Preview the contents of the selected directory - ALT-C
      "--preview 'exa -l --tree --level=2 --color=always {}'"
    ];

    historyWidgetOptions = [
      "--preview-window=:hidden"
    ];
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[V](bold green) ";
      };

      # package.disabled = true;
    };
  };

  # TODO: fix config does not seem to work
  programs.tmux = {
    enable = true;
    tmuxinator.enable  = true;
    # prefix = "C-a";
    shortcut = "a";
    baseIndex = 1;

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.fpp
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.pain-control
      # tmuxPlugins.vim-tmux-navigator
      # tmuxPlugins.dracula
    ];
    extraConfig = ''
      ${builtins.readFile ../../dotfiles/new.tmux.conf}
    '';
  };

  home = 
    let NODE_GLOBAL = "${config.home.homeDirectory}/.node-packages";
  in {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    sessionVariables = {
      GPG_TTY = "/dev/ttys000";
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk11.home}";
      NODE_PATH = "${NODE_GLOBAL}/lib";
      # HOMEBREW_NO_AUTO_UPDATE = 1;
    };
    sessionPath = [
      "${NODE_GLOBAL}/bin"
    ];

    packages = with pkgs; [
      coreutils
      lua
      fzf
      fd
      jq
      readline
      tldr
      ripgrep
      shellcheck
      graphviz
      gnupg
      zenith
      htop
      bottom
      tree
      neofetch
      curl
      wget
      glow
      universal-ctags
      unzip
      gnused
      starship
      pre-commit
      exa

      bat
      bat-extras.batgrep
      bat-extras.batman
      bat-extras.batwatch
      bat-extras.prettybat

      terraform
      docker
      docker-compose
      google-cloud-sdk
    ];

    file = {
      hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ../../dotfiles/hammerspoon;
        target = ".hammerspoon";
        recursive = true;
      };
      functions = {
        source = ../../dotfiles/functions;
        target = ".functions";
        recursive = true;
      };
      ctags = {
        source = ../../dotfiles/ctags;
        target = ".ctags";
        recursive = true;
      };
      tmuxinator = {
        source = ../../dotfiles/config/tmuxinator;
        target = ".config/tmuxinator";
        recursive = true;
      };
    };
  };
}