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
            target = ".config/nvim/lua/settings.lua";
        };
        mappings = {
            source = ../../../dotfiles/config/nvim/lua/rb/mappings.lua;
            target = ".config/nvim/lua/mappings.lua";
        };
        globals = {
            source = ../../../dotfiles/config/nvim/lua/rb/globals.lua;
            target = ".config/nvim/lua/globals.lua";
        };
        autocommands = {
            source = ../../../dotfiles/config/nvim/lua/rb/autocmd.lua;
            target = ".config/nvim/lua/autocmd.lua";
        };
        autopairs = {
            source = ../../../dotfiles/config/nvim/lua/rb/autopairs;
            target = ".config/nvim/lua/autopairs";
        };
        nvim-cmp = {
            source = ./lua/nvim-cmp.lua;
            target = ".config/nvim/lua/nvim-cmp.lua";
        };
        indent-blankline = {
            source = ./lua/indent-blankline.lua;
            target = ".config/nvim/lua/indent-blankline.lua";
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


        ];
        extraConfig = ''
            luafile ~/.config/nvim/lua/settings.lua
            luafile ~/.config/nvim/lua/mappings.lua
            luafile ~/.config/nvim/lua/globals.lua
            luafile ~/.config/nvim/lua/autocmd.lua
            luafile ~/.config/nvim/lua/nvim-cmp.lua
            luafile ~/.config/nvim/lua/indent-blankline.lua
            lua require("autopairs")
        '';
    };
}
