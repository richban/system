{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2
    kubectl
    postgresql
    # kubernetes-helm
  ];
  home.sessionVariables = {
    AWS_PROFILE = "analytics";
  };
}
