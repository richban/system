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

    bat.enable = config.programs.bat.enable;
    bottom.enable = config.programs.bottom.enable;
    fzf.enable = config.programs.fzf.enable;
    gh-dash.enable = config.programs.gh.extensions.gh-dash;
    gitui.enable = config.programs.gitui.enable;
    starship.enable = config.programs.starship.enable;
    alacritty.enable = config.programs.alacritty.enable;
    ghostty.enable = config.programs.ghostty.enable;
    zsh-syntax-highlighting.enable = true;
    delta.enable = true;

    tmux.enable = config.programs.tmux.enable;
    tmux.extraConfig = ''
      # Window style
      set -g @catppuccin_window_status_style "rounded"
      set -g @catppuccin_window_number_position "right"

      # Inactive window
      set -g @catppuccin_window_fill "number"
      set -g @catppuccin_window_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}"

      # Active window
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}#{?window_zoomed_flag, (),}"

      # Status bar appearance
      set -g @catppuccin_status_background "#1e1e2e"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"

      # Module config
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
