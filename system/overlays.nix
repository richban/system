{inputs, ...}: {
  nixpkgs.overlays = [
    # channels
    (final: prev: {
      # expose other channels via overlays
      stable = import inputs.nixos-stable {system = prev.system;};
    })
    (
      final: prev: let
        pkgs = final;
      in
        with pkgs; {
          yabai = final.callPackage ./pkgs/yabai {
            inherit (darwin.apple_sdk_11_0.frameworks) SkyLight Cocoa Carbon ScriptingBridge;
          };

          yabai-zsh-completions = final.callPackage ./pkgs/yabai-zsh-completions {};
        }
    )
  ];
}
