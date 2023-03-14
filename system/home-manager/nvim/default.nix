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
      rev = "008de87749e6baa402a2ce2f3ebc75e724b95da1";
      sha256 = "atKpnfoT+AA96eZCQSo1ruy+qL+IHGRv3z5WygqJ1ro=";
    };
  };
  refactoring = pkgs.vimUtils.buildVimPlugin {
    name = "refactoring.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "57c32c6b7a211e5a3a5e4ddc4ad2033daff5cf9a";
      sha256 = "m/WCIF4GWMXkys4oii4GZ9RCO4cfUD/X6rCRtBLgj3A=";
    };
    buildInputs = [pkgs.stylua];
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
      source = ../../../dotfiles/config/nvim/lua/rb/statusline.lua;
      target = ".config/nvim/lua/rb/statusline.lua";
    };
    gitsigns = {
      source = ../../../dotfiles/config/nvim/lua/rb/gitsigns.lua;
      target = ".config/nvim/lua/rb/gitsigns.lua";
    };
    code-formatting = {
      source = ../../../dotfiles/config/nvim/lua/rb/code-formatting.lua;
      target = ".config/nvim/lua/rb/code-formatting.lua";
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
      indent-blankline-nvim
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
          vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>Git<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>Git blame<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>0Gclog!<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gj", "<cmd>diffget //2<CR>", { noremap = true, silent = true })
          vim.api.nvim_set_keymap("n", "<leader>gk", "<cmd>diffget //3<CR>", { noremap = true, silent = true })
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
      {
        plugin = null-ls-nvim;
        config = ''lua require('rb.code-formatting')'';
      }
      # https://nixos.wiki/wiki/Tree_sitters
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
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
      lspsaga-nvim-original
      lsp-status-nvim
      lsp_signature-nvim

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

      (python39.withPackages (ps:
        with ps; [
          python-lsp-server
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
      # editorconfig-checker
    ];

    extraPython3Packages = ps: with ps; [jedi];

    extraConfig = ''
      lua require("rb.settings")
      lua require("rb.mappings")
      lua require("rb.globals")
      lua require("rb.autocmd")
      lua require("rb.nvim-cmp")
      lua require("rb.indent-blankline")
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
