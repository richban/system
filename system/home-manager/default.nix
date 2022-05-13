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