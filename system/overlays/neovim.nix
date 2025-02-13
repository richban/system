{inputs, ...}: final: prev: {
  # Include neovim-nightly
  inherit (inputs.neovim-nightly-overlay.overlays.default final prev) neovim;

  # Custom vim plugins
  vimPlugins =
    prev.vimPlugins
    // {
      projections = prev.vimUtils.buildVimPlugin {
        name = "projections";
        src = inputs.projections;
      };
      nui = prev.vimUtils.buildVimPlugin {
        name = "nui";
        src = inputs.nui;
      };
      incRename = prev.vimUtils.buildVimPlugin {
        name = "inc-rename";
        src = inputs.incRename;
      };
      diffview = prev.vimUtils.buildVimPlugin {
        name = "diffview";
        src = inputs.diffview;
      };
      oxacarbonColors = prev.vimUtils.buildVimPlugin {
        name = "oxocarbon";
        src = inputs.oxacarbonColors;
      };
      copilot = prev.vimUtils.buildVimPlugin {
        name = "copilot";
        src = inputs.copilot;
      };
      copilotCmp = prev.vimUtils.buildVimPlugin {
        name = "copilot-cmp";
        src = inputs.copilotCmp;
      };
      copilotLualine = prev.vimUtils.buildVimPlugin {
        name = "copilot-lualine";
        src = inputs.copilotLualine;
      };
      copilotChat = prev.vimUtils.buildVimPlugin {
        name = "CopilotChat.nvim";
        src = inputs.copilotChat;
      };
      conformNvim = prev.vimUtils.buildVimPlugin {
        name = "conform.nvim";
        src = inputs.conformNvim;
      };
      ropeVim = prev.vimUtils.buildVimPlugin {
        name = "ropevim";
        src = inputs.ropeVim;
      };
    };
}
