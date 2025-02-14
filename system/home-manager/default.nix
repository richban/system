{
  inputs,
  config,
  pkgs,
  lib,
  stateVersion,
  username,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin;
  homeDir = config.home.homeDirectory;

  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./zsh.nix
    ./git.nix
    ./nvim/config.nix
    ./1password.nix
    ./direnv.nix
    ./alacritty.nix
    ./starship.nix
  ];

  xdg = {
    enable = true;
    configHome = "${homeDir}/${relativeXDGConfigPath}";
    dataHome = "${homeDir}/${relativeXDGDataPath}";
    cacheHome = "${homeDir}/${relativeXDGCachePath}";
  };

  # Enable the Catppuccin theme
  catppuccin = {
    accent = "blue";
    flavor = "mocha";
    bat.enable = config.programs.bat.enable;
    bottom.enable = config.programs.bottom.enable;
    fzf.enable = config.programs.fzf.enable;
    gh-dash.enable = config.programs.gh.extensions.gh-dash;
    gitui.enable = config.programs.gitui.enable;
    starship.enable = config.programs.starship.enable;
    alacritty.enable = config.programs.alacritty.enable;
    tmux.enable = config.programs.tmux.enable;
    zsh-syntax-highlighting.enable = true;
    delta.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batwatch
      prettybat
      batman
    ];
    config = {
      style = "plain";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--info=inline"
    ];

    fileWidgetOptions = [
      "--preview 'bat --color=always --plain {}'"
    ];

    changeDirWidgetOptions = [
      "--preview 'eza -l --tree --level=2 --color=always {}'"
    ];

    historyWidgetOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--ansi"
      # Process command with syntax highlighting
      "--preview 'echo {} | bat --color=always --plain --language=sh'"
      "--preview-window=:hidden"
    ];
  };

  # programs.starship = {
  #   enable = true;
  #   # Configuration written to ~/.config/starship.toml
  #   settings = {
  #     "$schema" = "https://starship.rs/config-schema.json";

  #     add_newline = true;

  #     character = {
  #       success_symbol = "[➜](bold green)";
  #       error_symbol = "[➜](bold red)";
  #       vicmd_symbol = "[V](bold green) ";
  #     };

  #     # package.disabled = true;
  #   };
  # };

  programs.bottom = {
    enable = true;
    settings = {
      disk_filter = {
        is_list_ignored = true;
        list = ["/dev/loop"];
        regex = true;
        case_sensitive = false;
        whole_word = false;
      };
      flags = {
        dot_marker = false;
        enable_gpu_memory = true;
        group_processes = true;
        hide_table_gap = true;
        mem_as_value = true;
        tree = true;
      };
    };
  };

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    shortcut = "a";
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";

    # Add default command to ensure login shell
    extraConfig = ''
      ${builtins.readFile ../../dotfiles/config/tmux/tmux.conf}
      set-option -g default-command "${pkgs.zsh}/bin/zsh"
    '';

    plugins = with pkgs; [
      # Core plugins
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.fpp

      # Session management
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty'
        '';
      }
    ];
  };

  programs.go.enable = true;

  programs.ssh = {
    enable = true;
    forwardAgent = true;
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

  home = {
    inherit stateVersion;
    inherit username;
    homeDirectory =
      if isDarwin
      then "/Users/${username}"
      else "/home/${username}";
    sessionVariables = {
      GPG_TTY = "/dev/ttys000";
      EDITOR = "nvim";
      VISUAL = "nvim";
      JAVA_HOME = "${pkgs.openjdk11.home}";
      NODE_PATH = "${homeDir}/.node";
    };
    sessionPath = [
      "${homeDir}/.local/bin"
      "${homeDir}/.node/bin"
    ];

    packages = with pkgs; [
      # CLI Utilities
      jq # JSON processor and formatter
      jiq # Modern Unix `jq`
      fzf # Fuzzy file finder
      fd # Simple find alternative
      ripgrep # Fast text search tool
      tree # Directory structure viewer
      eza # Modern ls replacement
      moreutils # Additional Unix tools
      htop # System monitoring tool
      neofetch # System info display
      curl # URL transfer tool
      wget # File download utility
      glow # Markdown CLI renderer
      unzip # Archive extraction tool
      gnused # Stream editor
      universal-ctags # Code indexing tool

      # Development Tools
      lua # Lua programming language
      readline # Line editing library
      shellcheck # Shell script analyzer
      graphviz # Graph visualization
      treefmt # Code formatter
      shfmt # Shell formatter
      pre-commit # Git hooks manager
      git-sizer # Git repo analyzer
      git-lfs # Git large file storage

      # Ruby Environment
      (pkgs.ruby.withPackages (ps: with ps; [jekyll]))

      # Infrastructure & Containers
      terraform # Infrastructure as code
      google-cloud-sdk # GCP toolkit

      nixfmt-rfc-style # Nix code formatter
      nixpkgs-review # Nix code review
      nix-prefetch-scripts # Nix code fetcher
      nurl # Nix URL fetcher

      # Python Environment
      (pkgs.python311.withPackages (ps:
        with ps; [
          duckdb # SQL database engine
          pandas # Data analysis library
          polars # Fast dataframe library
          jupyter # Interactive notebooks
          ipython # Enhanced Python shell
        ]))

      # Python Development Tools
      cookiecutter # Project template tool
      ruff # Fast Python linter
      uv # Python package installer
      sqlfluff # SQL linter

      # Node.js Environment
      nodejs_20 # JavaScript runtime
      nodePackages.npm # Node package manager

      asciicam # Terminal webcam
      bandwhich # Modern Unix `iftop`
      cpufetch # Terminal CPU info
      difftastic # Modern Unix `diff`
      fastfetch # Modern Unix system info
      ipfetch # Terminal IP info
    ];

    file = {
      hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ../../dotfiles/hammerspoon;
        target = ".hammerspoon";
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
