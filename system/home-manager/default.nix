{ inputs, config, pkgs, lib, ... }:

{
  imports = [./zsh.nix ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.fzf = {
    enable = true;
    fileWidgetOptions = [
      # Preview the contents of the selected file - CTRL+T
      "--preview 'bat --color=always --plain {}'"
    ];

    changeDirWidgetOptions = [
      # Preview the contents of the selected directory - ALT-C
      "--preview 'exa -l --tree --level=2 --color=always {}'"
    ];
  };

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
      gitAndTools.gh
      ripgrep
      shellcheck
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

    file = {
      hammerspoon = lib.mkIf pkgs.stdenvNoCC.isDarwin {
        source = ../../dotfiles/hammerspoon;
        target = ".hammerspoon";
        recursive = true;
      };
      functions = {
        source = ../../dotfiles/functions;
        target = ".functions";
        recursive = true;
      };
    };
  };
}