{pkgs, ...}: let
  # Map all grammars to their corresponding plugins
  treesitterGrammars = pkgs.symlinkJoin {
    name = "nvim-treesitter-grammars";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };
in {
  home.file = {
    nvim = {
      source = ../../../dotfiles/config/nvim;
      target = ".config/nvim";
      recursive = true;
    };
  };

  # Use a standalone .lua file that won't conflict with the recursive copy
  home.file.".local/share/nvim/site/plugin/treesitter-parsers.lua" = {
    text = ''
      vim.opt.runtimepath:append("${treesitterGrammars}")
    '';
  };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file.".local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = pkgs.vimPlugins.nvim-treesitter;
  };

  programs.neovim = {
    enable = true;
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
      (python311.withPackages (ps:
        with ps; [
          python-dotenv
          pynvim
        ]))
    ];
  };
}
