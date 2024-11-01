{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  home.file = {
    nvim = {
      source = ../../../dotfiles/config/nvim;
      target = ".config/nvim";
      recursive = true;
    };
  };

  # home.file."./.config/nvim/plugin/treesitter-parsers.lua" = {
  #   text = ''
  #     vim.opt.runtimepath:append("${treesitter-parsers}")
  #   '';
  # };

  # Treesitter is configured as a locally developed module in lazy.nvim
  # we hardcode a symlink here so that we can refer to it in our lazy config
  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitterWithGrammars;
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

    plugins = [
      treesitterWithGrammars
    ];

    extraPackages = with pkgs; [
      neovim-remote
      luajitPackages.tiktoken_core # copilot (optional)
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
