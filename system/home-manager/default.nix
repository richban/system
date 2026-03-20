{
  inputs,
  config,
  pkgs,
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
  ];

  catppuccin = {
    accent = "blue";
    flavor = "mocha";

    # bat.enable = config.programs.bat.enable;
    # bottom.enable = config.programs.bottom.enable;
    # fzf.enable = config.programs.fzf.enable;
    # gh-dash.enable = config.programs.gh.extensions.gh-dash;
    # gitui.enable = config.programs.gitui.enable;
    # starship.enable = config.programs.starship.enable;
    # alacritty.enable = config.programs.alacritty.enable;
    # ghostty.enable = config.programs.ghostty.enable;
    # zsh-syntax-highlighting.enable = true;
    # delta.enable = true;
    tmux.enable = config.programs.tmux.enable;
    tmux.extraConfig = ''
      # ── GitHub Dark — direct hex overrides ───────────────────────────────
      # GitHub Dark palette used:
      #   #0d1117  canvas default (bg)
      #   #21262d  overlay / surface0
      #   #30363d  surface1 / border
      #   #3d444d  surface2
      #   #484f58  overlay0 (muted)
      #   #8b949e  overlay2 (dimmed text)
      #   #e6edf3  fg (primary text)
      #   #58a6ff  blue (accent)
      #   #bc8cff  purple / mauve
      #   #3fb950  green
      #   #f0883e  orange / peach
      #   #f85149  red

      # ── Window ────────────────────────────────────────────────────────────
      set -g @catppuccin_window_status_style "basic"
      set -g @catppuccin_window_number_position "right"

      # Inactive window: dimmed bg + muted text
      set -g @catppuccin_window_number_color "#8b949e"
      set -g @catppuccin_window_text_color  "#21262d"
      set -g @catppuccin_window_text  "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}"

      # Active window: GitHub blue accent
      set -g @catppuccin_window_current_number_color "#58a6ff"
      set -g @catppuccin_window_current_text_color   "#30363d"
      set -g @catppuccin_window_current_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}#{?window_zoomed_flag, 󰁌 ,}"

      # ── Pane borders ──────────────────────────────────────────────────────
      set -g @catppuccin_pane_border_style          "fg=#30363d"
      set -g @catppuccin_pane_active_border_style   "fg=#58a6ff"

      # ── Status bar ────────────────────────────────────────────────────────
      set -g @catppuccin_status_background      "none"
      set -g @catppuccin_status_fill            "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_status_module_bg_color "#21262d"

      # ── Module config ─────────────────────────────────────────────────────
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
    '';
  };

  xdg = {
    enable = true;
    configHome = "${homeDir}/${relativeXDGConfigPath}";
    dataHome = "${homeDir}/${relativeXDGDataPath}";
    cacheHome = "${homeDir}/${relativeXDGCachePath}";
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

  programs.go.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = true;
      };
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
      EDITOR = "nvim";
      VISUAL = "nvim";
      NODE_PATH = "${homeDir}/.node";
      NPM_CONFIG_PREFIX = "${homeDir}/.npm-global";
    };
    sessionPath =
      [
        "${homeDir}/.local/bin"
        "${homeDir}/.node/bin"
        "${homeDir}/.duckdb/cli/latest"
        "${homeDir}/.npm-global/bin"
      ]
      ++ (
        if isDarwin
        then [
          "/opt/homebrew/bin"
          "/Applications/Obsidian.app/Contents/MacOS"
        ]
        else []
      );

    file = {
      ".npmrc".text = ''
        prefix=${homeDir}/.npm-global
      '';
    };
  };
}
