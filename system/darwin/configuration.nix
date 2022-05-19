{ inputs, config, pkgs, ... }:
let 
  callPackage = pkgs.callPackage;
  hammerspoon = callPackage ../hammerspoon.nix { };
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [ 
      alacritty
      hammerspoon
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.dotfiles/system/darwin";

  environment.loginShell = pkgs.zsh;

  environment.etc = { darwin.source = "${inputs.darwin}"; };

  nix.nixPath = [ "darwin=/etc/${config.environment.etc.darwin.target}" ];
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog¡
  system.stateVersion = 4;

  # Fonts
  # fonts.fontDir.enable = true;
  # fonts.fonts = with pkgs; [
  #   recursive
  #       (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  # ];

  services.yabai.enable = false;
  services.yabai.package = pkgs.yabai;
  services.skhd.enable = false;

  # users.users.richban = {
  #   description = "Richard Banyi";
  #   name = "richban";
  #   home = "/Users/richban";
  #   shell = pkgs.zsh;
  # };

  # let nix manage home-manager profiles and use global nixpkgs
  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   backupFileExtension = "backup";
  # };

  # home-manager.users.richban = { ... }: {
  #   imports = [ ../home-manager ];
  # };


  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;
 
}
