{
  config,
  pkgs,
  lib,
  ...
}: let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in {
  imports = [./zsh.nix ./alacritty.nix ./git.nix ./nvim/config.nix ./1password.nix ./direnv.nix];

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
      "--preview 'eza -l --tree --level=2 --color=always {}'"
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

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
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
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_modules_right "directory meetings date_time"
          set -g @catppuccin_status_modules_left "session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"

          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty'
        '';
      }
    ];
    extraConfig = ''
      ${builtins.readFile ../../dotfiles/config/tmux/tmux.conf}
    '';
  };

  programs.go.enable = true;

  programs.ssh = {
    enable = true;
    forwardAgent = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = ''
      # https://github.com/direnv/direnv/wiki/Customizing-cache-location
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
          echo "''${direnv_layout_dirs[$PWD]:=$(
              echo -n "${config.xdg.cacheHome}"/direnv/layouts/
              echo -n "$PWD" | shasum | cut -d ' ' -f 1
          )}"
      }
    '';
  };

  programs.vscode.enable = true;

  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {auto_update = true;};
    };
  };

  home = let
    NODE_GLOBAL = "${config.home.homeDirectory}/.node-packages";

    pyEnv =
      pkgs.python311.withPackages
      (ps:
        with ps; [
          black
          pandas
          jupyter
          ipython
        ]);
  in {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    stateVersion = "22.05";
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
      moreutils
      # tldr
      ripgrep
      shellcheck
      graphviz
      gnupg
      # zenith
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
      eza

      (pkgs.ruby.withPackages (ps: with ps; [jekyll]))

      treefmt
      # formats shell programs
      shfmt
      pre-commit
      git-sizer
      git-lfs

      bat
      bat-extras.batgrep
      bat-extras.batman
      bat-extras.batwatch
      bat-extras.prettybat

      terraform
      docker
      docker-compose
      google-cloud-sdk

      pyEnv
      cookiecutter
      ruff
      uv
      poetry
      sqlfluff

      nodejs_20
      nodePackages.npm
      yarn
    ];

    file = {
      hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ../../dotfiles/hammerspoon;
        target = ".hammerspoon";
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
      catppuccinMocha = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ../../dotfiles/config/alacritty/catppuccin-mocha.toml;
        target = ".config/alacritty/catppuccin/catppuccin-mocha.toml";
        recursive = true;
      };
    };
  };
}
