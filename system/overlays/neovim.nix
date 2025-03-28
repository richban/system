{inputs, ...}: final: prev: {
  # Include neovim-nightly
  inherit (inputs.neovim-nightly-overlay.overlays.default final prev) neovim;
}
