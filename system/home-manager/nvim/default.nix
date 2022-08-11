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
            {
                plugin = rose-pine;
                config = ''lua vim.cmd('colorscheme rose-pine')'';
            }
        ];
        extraConfig = ''
            luafile ~/.config/nvim/lua/settings.lua
            luafile ~/.config/nvim/lua/mappings.lua
            luafile ~/.config/nvim/lua/globals.lua
            luafile ~/.config/nvim/lua/autocmd.lua
        '';
    };
}
