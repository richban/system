{inputs, ...}: final: prev:
if prev.stdenv.isLinux
then {}
else {
  # Include neovim-nightly
  inherit (inputs.neovim-nightly-overlay.overlays.default final prev) neovim;
}
