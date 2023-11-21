{
  inputs,
  config,
  pkgs,
  ...
}: let
  callPackage = pkgs.callPackage;
  hammerspoon = callPackage ../hammerspoon.nix {};
  inherit (pkgs.stdenvNoCC) isAarch64 isAarch32;
in {
  homebrew.brewPrefix =
    if isAarch64 || isAarch32
    then "/opt/homebrew/bin"
    else "/usr/local/bin";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alacritty
    _1password
    _1password-gui
    hammerspoon
    spacebar
    # obsidian
    # postman
    karabiner-elements
    goku
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/Developer/dotfiles/system/darwin";

  environment.loginShell = pkgs.zsh;

  environment.etc = {darwin.source = "${inputs.darwin}";};

  # auto manage nixbld users with nix darwin
  nix = {
    configureBuildUsers = true;
    nixPath = ["darwin=/etc/${config.environment.etc.darwin.target}"];
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  security.pam.enableSudoTouchIdAuth = true;

  # # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog¡
  system.stateVersion = 4;
}
