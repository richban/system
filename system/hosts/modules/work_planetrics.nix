{pkgs, ...}: {
  home.packages = with pkgs; [
    awscli2
    kubectl
    postgresql
    # kubernetes-helm
  ];
  programs.git = {
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6/erFt5q36JNuiFG4FqiYE3flwgqyVL0FawLSSuPW8";
      signByDefault = true;
    };
  };
}
