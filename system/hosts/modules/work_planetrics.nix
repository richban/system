{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    awscli2
    kubectl
    # kubernetes-helm
  ];
}