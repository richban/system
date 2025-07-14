{
  self,
  inputs,
  pkgs,
  username,
  stateVersion,
  ...
}: {
  imports = [./nixpkgs.nix ./fonts.nix];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
    };
    info.enable = false;
    nix-index-database.comma.enable = true;
  };

  # bootsrap primary user
  users.users.${username} = {
    description = "Richard Banyi";
    name = "${username}";
    home = "${
      if pkgs.stdenvNoCC.isDarwin
      then "/Users"
      else "/home"
    }/${username}";
    shell = pkgs.zsh;
  };

  system.primaryUser = "${username}";

  # bootstrap home-manager
  home-manager.users.${username} = import ./home-manager;

  # Enable home-manager
  home-manager = {
    extraSpecialArgs = {inherit self inputs stateVersion username;};
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
      nix-prefetch-github
      nix-template
      cachix
    ];
    etc = {
      home-manager.source = "${inputs.home-manager}";
      nixpkgs.source = "${inputs.nixpkgs}";
      # stable.source = "${inputs.nixos-stable}";
    };
    # list of acceptable shells in /etc/shells
    shells = with pkgs; [bash zsh];
  };
}
