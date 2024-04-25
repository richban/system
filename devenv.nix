{
  self,
  pkgs,
  # inputs,
  # lib,
  ...
}: {
  packages = [
    pkgs.nixd
    self.packages.${pkgs.system}.pyEnv
    self.packages.${pkgs.system}.sysdo
    # (inputs.treefmt-nix.lib.mkWrapper pkgs (import ./treefmt.nix))
  ];

  pre-commit = {
    hooks = {
      black.enable = true;
      shellcheck.enable = false;
      alejandra.enable = true;
      shfmt.enable = false;
      stylua.enable = true;
      markdownlint.enable = false;
      deadnix = {
        settings = {
          noLambdaArg = true;
          edit = true;
        };
      };
    };
  };
}
