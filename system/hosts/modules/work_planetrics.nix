{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    awscli2
    kubectl
    # kubernetes-helm
  ];
  home.sessionVariables = {
    AWS_PROFILE = "PlanetViewSupport-richban";
  };
}