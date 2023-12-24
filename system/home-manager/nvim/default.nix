{
  config,
  pkgs,
  ...
}: let
  projections = pkgs.vimUtils.buildVimPlugin {
    name = "projections.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "gnikdroy";
      repo = "projections.nvim";
      rev = "f18a8505f84f45a0fe024cafca5b969447f63cd5";
      sha256 = "vkxiM+65k4/iAV2Y+FkFJpnB8/hArGA061JPNENjkvo=";
    };
  };
  refactoring = pkgs.vimUtils.buildVimPlugin {
    name = "refactoring.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "pre_release";
      sha256 = "k4nHB0VznnlDDOZayy1T36pydRO5cDVWV0OtJPtnDA0=";
    };
    buildInputs = [pkgs.stylua];
  };
  nui = pkgs.vimUtils.buildVimPlugin {
    name = "nui.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "MunifTanjim";
      repo = "nui.nvim";
      rev = "c8de23342caf8d50b15d6b28368d36a56a69d76f";
      sha256 = "Ao+xnowsZPR9x3Wm439l1QIlgt3Rt6n9DZIqkUKsR1k=";
    };
  };
  # chatgpt = pkgs.vimUtils.buildVimPlugin {
  #   name = "ChatGPT.nvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "jackMort";
  #     repo = "ChatGPT.nvim";
  #     rev = "be6d89615216339e8bee47f52290ae204372c248";
  #     sha256 = "2of3YTLlFw7GyjQ4dPztpqX+nwMF2Bvohc0R8krdx2A=";
  #   };
  # };
  inc-rename = pkgs.vimUtils.buildVimPlugin {
    name = "inc-rename.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "smjonas";
      repo = "inc-rename.nvim";
      rev = "ed0f6f2b917cac4eb3259f907da0a481b27a3b7e";
      sha256 = "i1VVtV86cpz7E3n9dOxVl6ZvxttqG3RqcxXrk2c/FCE=";
    };
  };
  # firenvim = pkgs.vimUtils.buildVimPlugin {
  #   name = "firenvim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "glacambre";
  #     repo = "firenvim";
  #     rev = "ee4ef314bd990b2b05b7fbd95b857159e444a2fe";
  #     sha256 = "hY6EcQ4y+t3EXe4qHAGjJ06Fo2bWjBc6W6XKpRZtYFM=";
  #   };
  # };
  diffview = pkgs.vimUtils.buildVimPlugin {
    name = "diffview.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "sindrets";
      repo = "diffview.nvim";
      rev = "8c1702470fd5186cb401b21f9bf8bdfad6d5cc87";
      sha256 = "6RDVUVLFqSws7ouZ1bRWsGfBpyVOHO+9yEiMFVWUbC0=";
    };
  };
  oxacarbon-colors = pkgs.vimUtils.buildVimPlugin {
    name = "nyoom-engineering";
    src = pkgs.fetchFromGitHub {
      owner = "nyoom-engineering";
      repo = "oxocarbon.nvim";
      rev = "b47c0ecab3a4270815afb3b05e03423b04cca8f2";
      sha256 = "sha256-HhHtEeQF0q4Sn13KfWesVbm2Kn5+pLjLrxepWvphcsI=";
    };
  };
  copilot = pkgs.vimUtils.buildVimPlugin {
    name = "copilot.vim";
    src = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "5b19fb001d7f31c4c7c5556d7a97b243bd29f45f";
      sha256 = "sha256-mHwK8vw3vbcMKuTb1aMRSL5GS0+4g3tw3G4uZGMA2lQ=";
    };
  };
in {
  home.file = {
    settings = {
      source = ../../../dotfiles/config/nvim/lua/rb/settings.lua;
      target = ".config/nvim/lua/rb/settings.lua";
    };
    mappings = {
      source = ../../../dotfiles/config/nvim/lua/rb/mappings.lua;
      target = ".config/nvim/lua/rb/mappings.lua";
    };
    globals = {
      source = ../../../dotfiles/config/nvim/lua/rb/globals.lua;
      target = ".config/nvim/lua/rb/globals.lua";
    };
    autocommands = {
      source = ../../../dotfiles/config/nvim/lua/rb/autocmd.lua;
      target = ".config/nvim/lua/rb/autocmd.lua";
    };
    auto = {
      source = ../../../dotfiles/config/nvim/lua/rb/auto.lua;
      target = ".config/nvim/lua/rb/auto.lua";
    };
    autopairs = {
      source = ../../../dotfiles/config/nvim/lua/rb/autopairs.lua;
      target = ".config/nvim/lua/rb/autopairs.lua";
    };
    nvim-cmp = {
      source = ../../../dotfiles/config/nvim/lua/rb/nvim-cmp.lua;
      target = ".config/nvim/lua/rb/nvim-cmp.lua";
    };
    indent-blankline = {
      source = ../../../dotfiles/config/nvim/lua/rb/indent-blankline.lua;
      target = ".config/nvim/lua/rb/indent-blankline.lua";
    };
    statusline = {
      source = ../../../dotfiles/config/nvim/lua/rb/statusline;
      target = ".config/nvim/lua/rb/statusline";
    };
    gitsigns = {
      source = ../../../dotfiles/config/nvim/lua/rb/gitsigns.lua;
      target = ".config/nvim/lua/rb/gitsigns.lua";
    };
    nvim-tree = {
      source = ../../../dotfiles/config/nvim/lua/rb/nvim-tree.lua;
      target = ".config/nvim/lua/rb/nvim-tree.lua";
    };
    nvim-treesitter = {
      source = ../../../dotfiles/config/nvim/lua/rb/nvim-treesitter.lua;
      target = ".config/nvim/lua/rb/nvim-treesitter.lua";
    };
    telescope = {
      source = ../../../dotfiles/config/nvim/lua/rb/telescope;
      target = ".config/nvim/lua/rb/telescope";
    };
    lsp = {
      source = ../../../dotfiles/config/nvim/lua/rb/lsp;
      target = ".config/nvim/lua/rb/lsp";
    };
    stylua = {
      source = ../../../dotfiles/config/nvim/lua/rb/stylua.lua;
      target = ".config/nvim/lua/rb/stylua.lua";
    };

    icons = {
      source = ../../../dotfiles/config/nvim/lua/rb/icons.lua;
      target = ".config/nvim/lua/rb/icons.lua";
    };

    projections = {
      source = ../../../dotfiles/config/nvim/lua/rb/projections.lua;
      target = ".config/nvim/lua/rb/projections.lua";
    };

    after = {
      source = ../../../dotfiles/config/nvim/after;
      target = ".config/nvim/after";
    };

    snippets = {
      source = ../../../dotfiles/config/nvim/snippets;
      target = ".config/nvim/snippets";
    };
  };

  programs.neovim = {
    enable = true;
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
      {
        plugin = rose-pine;
        type = "lua";
        config = ''
          require('rose-pine').setup({
            dark_variant = 'main',
            bold_vert_split = false,
            dim_nc_background = false,
            disable_background = false,
            disable_float_background = false,
            disable_italics = false,

            groups = {
              background = 'base',
              panel = 'surface',
              border = 'highlight_med',
              comment = 'muted',
              link = 'iris',
              punctuation = 'subtle',

              error = 'love',
              hint = 'iris',
              info = 'foam',
              warn = 'gold',

              headings = {
                h1 = 'iris',
                h2 = 'foam',
                h3 = 'rose',
                h4 = 'gold',
                h5 = 'pine',
                h6 = 'foam',
              }
            -- or set all headings at once
            -- headings = 'subtle'
            },

            -- Change specific vim highlight groups
            highlight_groups = {
              ColorColumn = { bg = 'highlight_low' }
            }
          })

          vim.cmd('colorscheme rose-pine')
        '';
      }
      {
        plugin = oxacarbon-colors;
        type = "lua";
        config = ''
          vim.opt.background = "dark" -- set this to dark or light
          vim.cmd.colorscheme "oxocarbon"
        '';
      }
      nvim-autopairs
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
      # snippets
      vim-vsnip

      # UI
      {
        plugin = nvim-web-devicons;
        config = ''lua require'nvim-web-devicons'.setup()'';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          vim.opt.termguicolors = true
          require("bufferline").setup {
            options = {
              numbers = function(opts)
                return string.format('%s', opts.lower(opts.ordinal))
              end,
              diagnostics = "nvim_lsp",
              show_tab_indicators = true,
              offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true
                }
              },
              separator_style = "slant",
              indicator = {
                style = "underline"
              },
            },
          }
          vim.cmd([[
              nnoremap <silent><TAB> :BufferLineCycleNext<CR>
              nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
          ]])
        '';
      }
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
      {
        plugin = vim-fugitive;
        type = "lua";
        config = ''
          vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>0Gclog!<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gj", "<cmd>diffget //2<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gk", "<cmd>diffget //3<CR>", { noremap = true, silent = true })
        '';
      }
      diffview
      {
        plugin = neogit;
        type = "lua";
        config = ''
          require("neogit").setup({
            disable_commit_confirmation = true,
            integrations = {
              diffview = true;
            }
          })
          vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Neogit kind=tab<CR>", { noremap = true, silent = true })
        '';
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
      null-ls-nvim
      # https://nixos.wiki/wiki/Tree_sitters
      # (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter.withAllGrammars
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
      # {
      #   plugin = lsp-fidget;
      #   type = "lua";
      #   config = ''require("fidget").setup()'';
      # }

      # telescope
      telescope-nvim
      telescope-file-browser-nvim
      telescope-fzy-native-nvim
      telescope-fzf-writer-nvim
      telescope-frecency-nvim
      telescope-dap-nvim
      telescope-project-nvim
      sqlite-lua

      vim-surround
      {
        plugin = neogen;
        type = "lua";
        config = ''
          require('neogen').setup({
            enabled = true,
            languages = {
              lua = {
                template = {
                  annotation_convention = "emmylua"
                }
              },
            }
          })
          local opts = { noremap = true, silent = true }
          vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
          vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
        '';
      }
      {
        plugin = projections;
      }
      {
        plugin = refactoring;
        type = "lua";
        config = ''require('refactoring').setup({})'';
      }
      {
        plugin = inc-rename;
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
      copilot
      # {
      #   plugin = codeium;
      #   type = "lua";
      #   config = ''require("codeium").setup({})'';
      # }
      # {
      #   plugin = chatgpt;
      #   type = "lua";
      #   config = ''require("chatgpt").setup({ })'';
      # }
    ];

    extraPackages = with pkgs; [
      neovim-remote
      rnix-lsp
      nixfmt
      sumneko-lua-language-server
      stylua
      luaformatter
      ccls
      sqls
      # sqlfluff
      deadnix
      statix
      proselint
      terraform-ls
      gitlint
      alejandra

      # nodePackages.beancount-langserver
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vim-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.fixjson
      nodePackages.prettier
      nodePackages.markdownlint-cli
      nodePackages.write-good

      (python310.withPackages (ps:
        with ps; [
          python-lsp-server
          ruff-lsp
          jedi
          # pylsp-mypy
          pyflakes
          pyls-flake8
          mypy
          mccabe
          pycodestyle
          python-lsp-black
          pyls-isort
          rope
          # editorconfig
        ]))

      tree-sitter
      codespell
      editorconfig-checker
    ];

    extraPython3Packages = ps: with ps; [jedi];

    extraConfig = ''
      lua require("rb.settings")
      lua require("rb.mappings")
      lua require("rb.globals")
      lua require("rb.autocmd")
      lua require("rb.nvim-cmp")
      lua require("rb.statusline")
      lua require("rb.gitsigns")
      lua require("rb.nvim-tree")
      lua require("rb.nvim-treesitter")
      lua require("rb.autopairs")
      lua require("rb.lsp")
      lua require("rb.telescope.setup")
      lua require("rb.telescope.mappings")
      lua require("rb.projections")
    '';
  };
}
