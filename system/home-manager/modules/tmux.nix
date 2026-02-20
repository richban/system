{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    shortcut = "a";
    baseIndex = 1;
    shell = "${pkgs.zsh}/bin/zsh";

    # Add default command to ensure login shell
    extraConfig = ''
      ${builtins.readFile ../../../dotfiles/config/tmux/tmux.conf}
      set-option -g default-command "${pkgs.zsh}/bin/zsh"
      set -g @vim_navigator_prefix_mapping_clear_screen ""
      set -g @continuum-boot 'on'
      set -g @continuum-boot-options 'alacritty'

      ${builtins.readFile ./../../dotfiles/config/tmux/tmux-aura-theme.conf}
    '';

    plugins = with pkgs; [
      # Core plugins
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.copycat
      tmuxPlugins.fpp
      tmuxPlugins.vim-tmux-navigator
      # tmuxPlugins.resurrect
      # tmuxPlugins.continuum
    ];
  };
}
