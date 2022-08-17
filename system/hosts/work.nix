{ config, lib, pkgs, ... }: {
    user.name = "richard_banyi";
    hm = { imports = [ ./modules/work_planetrics.nix ]; };
}