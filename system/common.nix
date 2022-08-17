{ inputs, config, lib, pkgs, ... }: {
  imports = [ ./primary.nix ./nixpkgs.nix ./overlays.nix];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  # bootsrap primary user
  user = {
    description = "Richard Banyi";
    name = "${config.user.name}";
    home = "${
        if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"
      }/${config.user.name}";
    shell = pkgs.zsh;
  };

  # bootstrap home-manager
  hm = import ./home-manager;

  # Enable home-manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  # environment setup
  environment = {
    systemPackages = with pkgs; [
      # standard toolset
      curl
      coreutils-full
      wget
      git
      jq
      gnupg

      nix-prefetch-github
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

  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
        # Selection of fonts from the package, you can overwrite the font selection
        (nerdfonts.override { fonts = [ "Hack" "FiraMono" ]; })
  ];
}