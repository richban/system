{
  pkgs,
  config,
  lib,
  flakeRoot,
  ...
}: let
  # Map all grammars to their corresponding plugins
  treesitterGrammars = pkgs.symlinkJoin {
    name = "nvim-treesitter-grammars";
    paths = (pkgs.vimPlugins.nvim-treesitter.withAllGrammars).dependencies;
  };
in {
  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${flakeRoot}/dotfiles/config/nvim";
    };

    ".local/share/nvim/nix/nvim-treesitter-parsers/" = {
      source = treesitterGrammars;
    };

    ".local/share/nvim/nix/nvim-treesitter/" = {
      recursive = true;
      source = pkgs.vimPlugins.nvim-treesitter;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim; # use neovim-nightly-overlay's build only on darwin
    coc.enable = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # nvim plugin providers
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    extraLuaPackages = luaPkgs:
      with luaPkgs; [
        tiktoken_core
        magick
      ];

    extraPackages = with pkgs; [
      neovim-remote
      cargo # for mason
      alejandra # nix formatter
      ruff
      nil
      (python312.withPackages (
        ps:
          with ps; [
            python-dotenv
            pynvim
          ]
      ))
    ];
  };
}
