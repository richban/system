{ config, pkgs, lib, ... }: {

     home.file = {
        settings = {
            source = ../../../dotfiles/config/nvim/lua/rb/settings.lua;
            target = ".config/nvim/lua/settings.lua";
        };
        mappings = {
            source = ../../../dotfiles/config/nvim/lua/rb/mappings.lua;
            target = ".config/nvim/lua/mappings.lua";
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
        ];
        extraConfig = ''
            luafile ~/.config/nvim/lua/settings.lua
            luafile ~/.config/nvim/lua/mappings.lua
        '';
    };
}
