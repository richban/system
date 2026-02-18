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
    sessionPath = [
      "${homeDir}/.local/bin"
      "${homeDir}/.node/bin"
      "${homeDir}/.duckdb/cli/latest"
      "${homeDir}/.npm-global/bin"
    ];

    file = {
      ".npmrc".text = ''
        prefix=${homeDir}/.npm-global
      '';
    };
  };
}
