{ inputs, config, lib, pkgs, ... }: {
  imports = [ ./nixpkgs.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

#   user = {
#     description = "Richard Banyi";
#     home = "${
#         if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"
#       }/${config.user.name}";
#     shell = pkgs.zsh;
#   };

  users.users.richban = {
    description = "Richard Banyi";
    name = "richban";
    home = "/Users/richban";
    shell = pkgs.zsh;
  };

  # bootstrap home manager using system config
  # home-manager.users.richban = { ... }: {
  #   imports = [ ./home-manager ];
  # };

  # # let nix manage home-manager profiles and use global nixpkgs
  # home-manager = {
  #   extraSpecialArgs = { inherit inputs; };
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   backupFileExtension = "backup";
  # };

  # environment setup
  environment = {
    systemPackages = with pkgs; [
      # standard toolset
      curl
      jq
      gnupg

      # helpful shell stuff
      bat
      fzf
      ripgrep
    ];
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${pkgs.path}";
      stable.source = "${inputs.nixos-stable}";
    };
    # list of acceptable shells in /etc/shells
    shells = with pkgs; [ bash zsh ];
  };

  # Fonts
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    recursive
        # Selection of fonts from the package, you can overwrite the font selection
        (nerdfonts.override { fonts = [ "Hack"]; })
  ];
}