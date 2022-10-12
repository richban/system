{ config, pkgs, lib, ... }:
let
  # FIXME: failing to build derivation
  # github-nvim-theme = pkgs.vimUtils.buildVimPlugin {
  #     name = "github-nvim-theme";
  #     src = pkgs.fetchFromGitHub {
  #         owner = "projekt0n";
  #         repo = "github-nvim-theme";
  #         rev = "main";
  #         sha256 = "sha256-wLX81wgl4E50mRig9erbLyrxyGbZllFbHFAQ9+v60W4=";
  #     };
  # };
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
        config = ''lua vim.cmd('colorscheme rose-pine')'';
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
      nvim-treesitter
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
    ];

    extraPackages = with pkgs; [
      neovim-remote
      rnix-lsp
      nixfmt
      sumneko-lua-language-server
      stylua
      ccls
      sqls
      # sqlfluff
      deadnix
      statix
      proselint
      terraform-ls
      # nodePackages.beancount-langserver
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
      nodePackages.vscode-html-languageserver-bin
      nodePackages.vscode-css-languageserver-bin
      nodePackages.vim-language-server
      nodePackages.dockerfile-language-server-nodejs

      python39Packages.python-lsp-server
      tree-sitter
    ];

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
      lua require("rb.telescope")
      lua require("rb.telescope.mappings")

    '';
  };
}
