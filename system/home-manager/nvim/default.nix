{
  pkgs,
  config,
  ...
}: let
  # Map all grammars to their corresponding plugins
  treesitterGrammars = pkgs.symlinkJoin {
    name = "nvim-treesitter-grammars";
    paths =
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins:
        with plugins; [
          bash
          c
          cpp
          css
          dockerfile
          gitattributes
          gitignore
          go
          gomod
          html
          javascript
          json
          lua
          make
          markdown
          nix
          python
          rust
          toml
          typescript
          vim
          yaml
        ])).dependencies;
  };
in {
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixpkgs/dotfiles/config/nvim";
    };

    ".local/share/nvim/site/plugin/treesitter-parsers.lua" = {
      text = ''
        vim.opt.runtimepath:append("${treesitterGrammars}")
      '';
    };

    ".local/share/nvim/nix/nvim-treesitter/" = {
      recursive = true;
      source = pkgs.vimPlugins.nvim-treesitter;
    };
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
