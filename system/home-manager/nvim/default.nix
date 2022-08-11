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
        autopairs = {
            source = ../../../dotfiles/config/nvim/lua/rb/autopairs;
            target = ".config/nvim/lua/rb/autopairs";
        };
        nvim-cmp = {
            source = ./lua/rb/nvim-cmp.lua;
            target = ".config/nvim/lua/rb/nvim-cmp.lua";
        };
        indent-blankline = {
            source = ./lua/rb/indent-blankline.lua;
            target = ".config/nvim/lua/rb/indent-blankline.lua";
        };
        statusline = {
            source = ./lua/rb/statusline.lua;
            target = ".config/nvim/lua/rb/statusline.lua";
        };
        gitsigns = {
            source = ./lua/rb/gitsigns.lua;
            target = ".config/nvim/lua/rb/gitsigns.lua";
        };
        code-formatting = {
            source = ./lua/rb/code-formatting.lua;
            target = ".config/nvim/lua/rb/code-formatting.lua";
        };
        nvim-tree = {
            source = ./lua/rb/nvim-tree.lua;
            target = ".config/nvim/lua/rb/nvim-tree.lua";
        };
        nvim-treesitter = {
            source = ./lua/rb/nvim-treesitter.lua;
            target = ".config/nvim/lua/rb/nvim-treesitter.lua";
        };
        telescope = {
            source = ./lua/rb/telescope;
            target = ".config/nvim/lua/rb/telescope";
        };

        after = {
            source = ../../../dotfiles/config/nvim/after/ftplugin;
            target = ".config/nvim/after/ftplugin";
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

            # lsp
            nvim-lspconfig
            lspsaga-nvim
            lsp-status-nvim
            lsp_signature-nvim

            # telescope
            telescope-nvim
            telescope-file-browser-nvim
            telescope-fzy-native-nvim
            telescope-fzf-writer-nvim
            telescope-frecency-nvim
            telescope-dap-nvim
            sqlite-lua


        ];

        extraPackages = with pkgs; [
            neovim-remote
            rnix-lsp
            nixfmt
            sumneko-lua-language-server
            stylua
            ccls
            proselint
            terraform-ls
            nodePackages.beancount-langserver
            nodePackages.typescript-language-server
            nodePackages.bash-language-server
            nodePackages.vscode-json-languageserver
            nodePackages.yaml-language-server
            nodePackages.vscode-html-languageserver-bin
            nodePackages.vscode-css-languageserver-bin
            nodePackages.vim-language-server
            nodePackages.dockerfile-language-server-nodejs
        ];

        extraConfig = ''
            luafile ~/.config/nvim/lua/rb/settings.lua
            luafile ~/.config/nvim/lua/rb/mappings.lua
            luafile ~/.config/nvim/lua/rb/globals.lua
            luafile ~/.config/nvim/lua/rb/autocmd.lua
            luafile ~/.config/nvim/lua/rb/nvim-cmp.lua
            luafile ~/.config/nvim/lua/rb/indent-blankline.lua
            luafile ~/.config/nvim/lua/rb/statusline.lua
            luafile ~/.config/nvim/lua/rb/gitsigns.lua
            luafile ~/.config/nvim/lua/rb/nvim-tree.lua
            luafile ~/.config/nvim/lua/rb/nvim-treesitter.lua

            lua require("rb.autopairs")
            lua require("rb.telescope")
            lua require("rb.telescope.mappings")

        '';
    };
}
