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
    inputs.catppuccin.homeModules.catppuccin
    ./zsh.nix
    ./git.nix
    ./nvim
    ./1password.nix
    ./direnv.nix
    ./alacritty.nix
    # ./starship.nix
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
    tmux.extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_status_background "#1e1e2e"
      set -g @catppuccin_status_fill "all"
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}#{?window_zoomed_flag,(),}"
      set -g @catppuccin_status_modules_right "directory meetings date_time"
      set -g @catppuccin_status_modules_left "session"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
    '';
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

      cmd_duration = {
        format = "[  $duration]($style)";
        min_time = 2500;
        min_time_to_notify = 60000;
        show_notifications = false;
        style = "fg:base";
      };
    };
  };

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
      set -g @vim_navigator_prefix_mapping_clear_screen ""
      set -g @continuum-boot 'on'
      set -g @continuum-boot-options 'alacritty'
    '';

    plugins = with pkgs; [
      # Core plugins
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.fpp
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
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
      JAVA_HOME = "${pkgs.jdk21_headless.home}";
      NODE_PATH = "${homeDir}/.node";
      SKHD_PID_FILE = "/tmp/skhd_${username}.pid";
    };
    sessionPath = [
      "${homeDir}/.local/bin"
      "${homeDir}/.node/bin"
      "${homeDir}/.duckdb/cli/latest" # DuckDB CLI Installed manually
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
      gemini-cli # Gemini CLI

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
      claude-code # Claude CLI
      fpp # Fuzzy path picker

      # Ruby Environment
      (pkgs.ruby.withPackages (ps: with ps; [jekyll]))

      # Java
      jdk21_headless

      # Infrastructure & Containers
      terraform # Infrastructure as code
      google-cloud-sdk # GCP toolkit
      awscli # AWS Command Line Interface

      nixfmt-rfc-style # Nix code formatter
      nixpkgs-review # Nix code review
      nix-prefetch-scripts # Nix code fetcher
      nurl # Nix URL fetcher

      # Python Environment
      # (pkgs.python311.withPackages (ps:
      #   with ps; [
      #     duckdb # SQL database engine
      #     pandas # Data analysis library
      #     polars # Fast dataframe library
      #     jupyter # Interactive notebooks
      #     ipython # Enhanced Python shell
      #   ]))
      # duckdb # SQL database engine
      cookiecutter # Project template tool
      ruff # Fast Python linter
      uv # Python package installer
      sqlfluff # SQL linter

      # Node.js Environment
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
      karabiner = {
        source = ../../dotfiles/config/karabiner;
        target = ".config/karabiner";
        recursive = true;
      };
    };
  };
}
