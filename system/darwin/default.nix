{
  inputs,
  hostname,
  platform,
  username,
  ...
}: {
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    # inputs.determinate.darwinModules.default
    inputs.home-manager.darwinModules.home-manager
    inputs.nix-index-database.darwinModules.nix-index
    ../common.nix
    ./wm.nix
    ./preferences.nix
    ./brew.nix
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta =
      if (platform == "aarch64-darwin")
      then true
      else false;
    autoMigrate = true;
    user = "${username}";
    mutableTaps = true;
  };

  networking.hostName = hostname;
  networking.computerName = hostname;

  documentation.enable = true;
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.man.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
