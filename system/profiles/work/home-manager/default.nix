{...}: {
  imports = [
    ./packages.nix
    ./git.nix
    ../../../home-manager/modules/tmux.nix
    ../../../home-manager/modules/zsh.nix
    # ../../../home-manager/modules/nvim
    ../../../home-manager/modules/direnv.nix
    ../../../home-manager/programs.nix
  ];
}
