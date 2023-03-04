{
  self,
  inputs,
  pkgs,
  lib,
  ...
}: {
  packages = [
    pkgs.rnix-lsp
    self.packages.${pkgs.system}.pyEnv
    self.packages.${pkgs.system}.sysdo
    (inputs.treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
  ];

  pre-commit = {
    hooks = {
      black.enable = true;
      shellcheck.enable = true;
      alejandra.enable = true;
      deadnix.enable = true;
      shfmt.enable = false;
      stylua.enable = true;
      markdownlint.enable = false;
    };

    settings = {
      deadnix.edit = true;
      deadnix.noLambdaArg = true;
    };
  };
}
