{pkgs, ...}: {
  imports = [
    ../../../home-manager/modules/tmux.nix
    ../../../home-manager/modules/zsh.nix
    ../../../home-manager/modules/git.nix
    ../../../home-manager/modules/nvim
    ../../../home-manager/modules/direnv.nix
    ../../../home-manager/programs.nix
  ];

  # Minimal package set for work Linux environment
  home.packages = with pkgs; [
    azure-cli
    python3
  ];
}
