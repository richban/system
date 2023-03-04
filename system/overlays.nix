{inputs, ...}: {
  nixpkgs.overlays = [
    # channels
    (final: prev: {
      # expose other channels via overlays
      stable = import inputs.nixos-stable {system = prev.system;};
    })
    # (final: prev: {
    #   python3 = prev.python3.override {
    #     packageOverrides = (pfinal: pprev: {
    #       pyopenssl = pprev.pyopenssl.overrideAttrs (old: {
    #         meta = old.meta // { broken = false; };
    #       });
    #     });
    #   };
    #   python39 = prev.python39.override {
    #     packageOverrides = (pfinal: pprev: {
    #       pyopenssl = pprev.pyopenssl.overrideAttrs (old: {
    #         meta = old.meta // { broken = false; };
    #       });
    #     });
    #   };
    #   python310 = prev.python310.override {
    #     packageOverrides = (pfinal: pprev: {
    #       pyopenssl = pprev.pyopenssl.overrideAttrs (old: {
    #         meta = old.meta // { broken = false; };
    #       });
    #     });
    #   };
    # })
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
