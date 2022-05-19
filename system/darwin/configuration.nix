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
      spacebar
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

  # TODO: waiting for latest version
  services.yabai = {
    enable = false;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    extraConfig = builtins.readFile ../../dotfiles/yabairc;
  };

  services.skhd.enable = false;
  services.skhd.skhdConfig = builtins.readFile ../../dotfiles/skhdrc;

  # TODO: move to a module
  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position                   = "bottom";
      display                    = "all";
      height                     = 26;
      title                      = "on";
      spaces                     = "on";
      clock                      = "off";
      power                      = "off";
      padding_left               = 20;
      padding_right              = 20;
      spacing_left               = 25;
      spacing_right              = 15;
      text_font                  = ''"Hack Nerd Font Mono:Regular:12.0"'';
      icon_font                  = ''"Font Awesome 5 Free:Solid:12.0"'';
      background_color           = "0xff202020";
      foreground_color           = "0xffa8a8a8";
      power_icon_color           = "0xffcd950c";
      battery_icon_color         = "0xffd75f5f";
      dnd_icon_color             = "0xffa8a8a8";
      clock_icon_color           = "0xffa8a8a8";
      power_icon_strip           = " ";
      space_icon                 = "•";
      space_icon_strip           = "1 2 3 4 5 6 7 8 9 10";
      spaces_for_all_displays    = "on";
      display_separator          = "on";
      display_separator_icon     = "";
      space_icon_color           = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary  = "0xfffff9b0";
      clock_icon                 = "";
      dnd_icon                   = "";
      clock_format               = ''"%d/%m/%y %R"'';
      right_shell                = "on";
      right_shell_icon           = "";
      right_shell_command        = "whoami";
    };
  };

  # Home Manager
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
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
 
}
