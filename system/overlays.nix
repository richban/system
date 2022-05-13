{ inputs, lib, ... }: {
  nixpkgs.overlays = [
    # channels
    (final: prev: {
      # expose other channels via overlays
      stable = import inputs.nixos-stable { system = prev.system; };
    })
  ];
}