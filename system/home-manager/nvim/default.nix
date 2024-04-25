{pkgs, ...}: {
  home.file = {
    settings = {
      source = ../../../dotfiles/config/nvim/lua;
      target = ".config/nvim/lua";
      recursive = true;
    };

    after = {
      source = ../../../dotfiles/config/nvim/after;
      target = ".config/nvim/after";
      recursive = true;
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    coc.enable = false;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # nvim plugin providers
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      # theme
      # {
      #   plugin = rose-pine;
      #   type = "lua";
      #   config = ''
      #     require('rb.colorscheme').config()
      #   '';
      # }
      # {
      #   plugin = oxacarbonColors;
      #   type = "lua";
      #   config = ''
      #     vim.opt.background = "dark" -- set this to dark or light
      #     vim.cmd.colorscheme "oxocarbon"
      #   '';
      # }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup({
            flavour = "mocha",
            background = {
                light = "latte",
                dark = "mocha",
            },
          })

          vim.cmd.colorscheme "catppuccin"
        '';
      }
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup({
            disable_filetype = { "TelescopePrompt" , "vim" },
          })
        '';
      }
      # adds vscode-like pictogram
      lspkind-nvim
      # completion engine
      nvim-cmp
      # completion sources
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-path
      cmp-nvim-lua
      cmp-spell
      cmp-vsnip
      {
        plugin = copilotCmp;
        type = "lua";
        config = ''
          require("copilot").setup({})'';
      }
      copilotLualine
      # snippets
      luasnip
      cmp_luasnip
      # vim-vsnip
      # vim-vsnip-integ
      friendly-snippets
      # UI
      {
        plugin = nvim-web-devicons;
        config = ''lua require'nvim-web-devicons'.setup()'';
      }
      # {
      #   plugin = bufferline-nvim;
      #   type = "lua";
      #   config = ''require("rb.bufferline").config()'';
      # }
      {
        plugin = indent-blankline-nvim;
        config = ''lua require("ibl").setup()'';
      }
      lualine-nvim
      {
        plugin = nvim-colorizer-lua;
        config = ''lua require'colorizer'.setup()'';
      }
      gitsigns-nvim
      vim-fugitive
      diffview
      {
        plugin = neogit;
        type = "lua";
        config = ''require("rb.neogit").config()'';
      }
      {
        plugin = neoscroll-nvim;
        config = ''lua require('neoscroll').setup()'';
      }
      {
        plugin = todo-comments-nvim;
        config = ''lua require("todo-comments").setup()'';
      }
      nvim-tree-lua
      vim-nix
      # null-ls-nvim
      # https://nixos.wiki/wiki/Tree_sitters
      # (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter.withAllGrammars
      # {
      #   plugin = nvim-treesitter.withPlugins (p: [
      #     p.tree-sitter-nix
      #     p.tree-sitter-vim
      #     p.tree-sitter-bash
      #     p.tree-sitter-lua
      #     p.tree-sitter-python
      #     p.tree-sitter-json
      #   ]);
      # }
      # markdown-preview-nvim
      # goyo-vim
      {
        plugin = nvim-comment;
        config = ''lua require("nvim_comment").setup()'';
      }
      {
        plugin = nvim-lastplace;
        config = ''lua require'nvim-lastplace'.setup{}'';
      }
      {
        plugin = trouble-nvim;
        config = ''lua require("trouble").setup()'';
      }
      {
        plugin = better-escape-nvim;
        config = ''lua require("better_escape").setup()'';
      }
      {
        plugin = hop-nvim;
        config = ''lua require'hop'.setup()'';
      }
      # lsp
      nvim-lspconfig
      # lspsaga
      lspsaga-nvim
      lsp-status-nvim
      lsp_signature-nvim
      {
        plugin = fidget-nvim;
        type = "lua";
        config = ''require("fidget").setup()'';
      }

      # telescope
      telescope-nvim
      telescope-file-browser-nvim
      telescope-fzy-native-nvim
      telescope-fzf-writer-nvim
      telescope-frecency-nvim
      telescope-dap-nvim
      telescope-project-nvim
      telescope-ui-select-nvim

      # vim-surround
      {
        plugin = mini-nvim;
        type = "lua";
        config = ''
          -- Better Around/Inside textobjects
          --
          -- Examples:
          --  - va)  - [V]isually select [A]round [)]paren
          --  - yinq - [Y]ank [I]nside [N]ext [']quote
          --  - ci'  - [C]hange [I]nside [']quote
          require('mini.ai').setup { n_lines = 500 }

          -- Add/delete/replace surroundings (brackets, quotes, etc.)
          --
          -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
          -- - sd'   - [S]urround [D]elete [']quotes
          -- - sr)'  - [S]urround [R]eplace [)] [']
          require('mini.surround').setup()
        '';
      }
      # annotations
      {
        plugin = neogen;
        type = "lua";
        config = ''require('rb.neogen').config()'';
      }
      {
        plugin = projections;
      }
      # {
      #   plugin = refactoring;
      #   type = "lua";
      #   config = ''require('refactoring').setup({})'';
      # }
      {
        plugin = incRename;
        type = "lua";
        config = ''require('inc_rename').setup({})'';
      }
      # {
      #   plugin = firenvim;
      #   type = "lua";
      #   config = ''vim.fn["firenvim#install"](0)'';
      # }

      # AI
      nui
      {
        plugin = copilot;
        type = "lua";
        config = ''require("rb.copilot").config()'';
      }
      {
        plugin = copilotChat;
        type = "lua";
        config = ''
          require("rb.copilotchat").mappings()
          require("rb.copilotchat").config()
        '';
      }
      {
        plugin = conformNvim;
        type = "lua";
        config = ''require("rb.conform").config()'';
      }
      mason-nvim
      mason-lspconfig-nvim
      mason-tool-installer-nvim
      ropeVim
    ];

    extraPackages = with pkgs; [
      luajitPackages.tiktoken_core
      neovim-remote
      cargo # for mason
      # nixfmt
      # sumneko-lua-language-server
      # stylua
      # luaformatter
      # ccls
      # sqls
      # sqlfluff
      # deadnix
      # statix
      # proselint
      # terraform-ls
      # gitlint
      # alejandra

      # nodePackages.beancount-langserver
      # nodePackages.typescript-language-server
      # nodePackages.bash-language-server
      # nodePackages.vscode-json-languageserver
      # nodePackages.yaml-language-server
      # nodePackages.vscode-html-languageserver-bin
      # nodePackages.vscode-css-languageserver-bin
      # nodePackages.vim-language-server
      # nodePackages.dockerfile-language-server-nodejs
      # nodePackages.fixjson
      # nodePackages.prettier
      # nodePackages.markdownlint-cli
      # nodePackages.write-good
    ];

    extraPython3Packages = ps:
      with ps; [
        isort
        black
        pyflakes
        pyls-flake8
        mypy
        mccabe
        pycodestyle
        rope
        pylsp-rope
        editorconfig
        tiktoken
        prompt-toolkit
        pynvim
      ];

    extraConfig = ''
      lua require("rb.settings")
      lua require("rb.mappings")
      lua require("rb.globals")
      lua require("rb.autocmd")
      lua require("rb.statusline")
      lua require("rb.gitsigns")
      lua require("rb.nvim-tree")
      lua require("rb.nvim-treesitter")
      lua require("rb.lsp")
      lua require("rb.telescope.setup")
      lua require("rb.telescope.mappings")
      lua require("rb.projections")
      lua require("rb.nvim-cmp")
    '';
  };
}
