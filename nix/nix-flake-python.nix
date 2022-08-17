{
  description = "Flake to manage python environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mach-nix.url = "mach-nix/3.5.0";
    # pypi-deps-db = {
    #   url = "github:davhau/pypi-deps-db/f61b6cc4a8b345ea07526c6a3929a8cbc0cc87a8";
    #   flake = false;
    # };
    # mach-nix.inputs.pypi-deps-db.follows = "pypi-deps-db";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@ { self, nixpkgs, mach-nix, flake-utils, ... }:
    let
      python = "python39";
      pypiDataRev = "master";
      pypiDataSha256 = "1jvs51gsy3dy0ajgkk0yw7h06rrifji3wgc9sk2pamzlpmv03lgk";
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        mach = import mach-nix { inherit pkgs python pypiDataRev pypiDataSha256; };

        pyDevEnv = (pkgs.${python}.withPackages
          (ps: with ps; [ pip black pylint pyflakes isort ]));

        pyEnv = mach.mkPython {
          requirements = builtins.readFile ./requirements.txt;
        };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            pyEnv
            pyDevEnv
            treefmt
          ];
        };
      }
    );
}

