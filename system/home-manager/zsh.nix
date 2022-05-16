{ config, pkgs, libs, ... }:
{
    programs.zsh = {
        enable = true;
        shellAliases = import ./aliases.nix;
    };
}