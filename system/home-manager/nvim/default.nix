{ config, pkgs, lib, ... }:
let
  github-nvim-theme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "github-nvim-theme";
    src = pkgs.fetchFromGitHub {
      owner = "projekt0n";
      repo = "github-nvim-theme";
      rev = "a0632f9fa9b696896d4b427de0c84c1e9f192204";
      sha256 = "sha256-cd9a8s2WIijsi4nvP1iu7/Dz7Mq8fxwFT0qOPuvyy00=";
    };
  };
  nvim-lastplace = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-lastplace";
    version = "2022-07-05";
    src = pkgs.fetchFromGitHub {
      owner = "ethanholz";
      repo = "nvim-lastplace";
      rev = "ecced899435c6bcdd81becb5efc6d5751d0dc4c8";
      sha256 = "030gc8q7xrkmqcsrx4h1issm4zjxxvypwawzq56kzm8x3d9bvbm0";
    };
    meta.homepage = "https://github.com/ethanholz/nvim-lastplace/";
  };
  lspsaga = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "lspsaga.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "glepnir";
      repo = "lspsaga.nvim";
      rev = "66ba565b835bb8b34dbad64c173afe89f39ea059";
      sha256 = "XYjzI9ogKRrHtojYRtZtTRLPw4Y6zxvrsmwg6c1r8N0=";
    };
  };
  annotation-toolkit = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neogen";
    src = pkgs.fetchFromGitHub {
      owner = "danymat";
      repo = "neogen";
      rev = "967b280d7d7ade52d97d06e868ec4d9a0bc59282";
      sha256 = "5wplf09XOljcQKYcnJTIQHJygNBVJw+tUcvWasLQbkc=";
    };
  };
  telescope-tabs = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "telescope-tabs";
    src = pkgs.fetchFromGitHub {
      owner = "LukasPietzschmann";
      repo = "telescope-tabs";
      rev = "7f2e038913f8bc39bb3d35f1bc94cb7d28fcfb7f";
      sha256 = "GQCaCWw2L0UFHTABrAk/g/d3MsGOj/XMxMbW2FgCI6c=";
    };
  };
  nvim-workspaces = pkgs.vimUtils.buildVimPlugin {
    name = "workspaces.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "natecraddock";
      repo = "workspaces.nvim";
      rev = "86fa201ecaf932358fb713c21b2078cdeb323dd1";
      sha256 = "VjfGtzSnxXdqYELAs/GnyWW83eu+L9rWPfWltClyLXY=";
    };
  };
  nvim-sessions = pkgs.vimUtils.buildVimPlugin {
    name = "sessions.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "natecraddock";
      repo = "sessions.nvim";
      rev = "7dbc83289ddb6527f761e3fa1de13fbc83e513d6";
      sha256 = "1qkqvcccz0gb30kw7layarx5dl9p35skfw5m3828kk0wxr8x7mim";
    };
  };

in
{

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
              ColorColumn = { bg = 'rose' }
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
          require("bufferline").setup{}
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
      null-ls-nvim
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
      editorconfig-vim
      # lsp
      nvim-lspconfig
      lspsaga
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
        plugin = annotation-toolkit;
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
        plugin = telescope-tabs;
        type = "lua";
        config = ''
          require'telescope-tabs'.setup{}
        '';
      }
      {
        plugin = nvim-workspaces;
        type = "lua";
        config = ''
          require("workspaces").setup({
            hooks = {
                open = { "NvimTreeRefresh", "Telescope find_files" },
            }
          })
        '';
      }
      {
        plugin = nvim-sessions;
        type = "lua";
        config = ''
          require("sessions").setup({
            events = { "WinEnter" },
            session_filepath = ".nvim/session",
          })
        '';
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

      (python3.withPackages (ps: with ps; [
        python-lsp-server
        jedi
        pylsp-mypy
        pyflakes
        pyls-flake8
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

    extraPython3Packages = ps: with ps; [ jedi ];

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
      lua require("rb.code-formatting")
      lua require("rb.lsp")
      lua require("rb.telescope")
      lua require("rb.telescope.mappings")
    '';
  };
}
