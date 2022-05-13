{ inputs, config, pkgs, ... }:

{
  imports = [];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;

  home = {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    username = "richban";
    homeDirectory = "/Users/richban";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";

    packages = with pkgs; [
      coreutils
      lua
      fzf
      fd
      jq
      readline
      tldr
      git
      gitAndTools.gh
      ripgrep
      shellcheck
      httpie
      graphviz
      gnupg
      git
      htop
      bottom
      tree
      neofetch
      curl
      wget
      glow
      ctags
      unzip
      gnused
      starship
      pre-commit
      exa

      terraform
      docker
      google-cloud-sdk
    ];
  };
}