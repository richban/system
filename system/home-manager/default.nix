{
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
    # inputs.catppuccin.homeModules.catppuccin
    ./packages.nix
    ./programs.nix
  ];
  #
  # catppuccin = {
  #   accent = "blue";
  #   flavor = "mocha";
  #
  #
  #   fzf.enable = config.programs.fzf.enable;
  #   gh-dash.enable = config.programs.gh.extensions.gh-dash;
  #   gitui.enable = config.programs.gitui.enable;
  #   starship.enable = config.programs.starship.enable;
  #   alacritty.enable = config.programs.alacritty.enable;
  #   ghostty.enable = config.programs.ghostty.enable;
  #   zsh-syntax-highlighting.enable = true;
  #   delta.enable = true;
  #   tmux.enable = config.programs.tmux.enable;
  # };

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
    settings = {
      "*" = {
        forwardAgent = true;
      };
    };
  };

  home = {
    inherit stateVersion;
    inherit username;
    enableNixpkgsReleaseCheck = false;
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
        "${homeDir}/.cache/bun/bin"
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
