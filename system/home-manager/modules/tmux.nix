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

      # Aura Theme for tmux (Catppuccin-style configuration with Aura colors)
      # Background and foreground colors
      set -g default-terminal "screen-256color"
      set -g terminal-overrides ",xterm-256color:RGB"

      # Aura color palette (matching the actual theme)
      aura_bg="#15141b"
      aura_fg="#edecee"
      aura_current="#29263c"
      aura_purple="#a277ff"
      aura_green="#61ffca"
      aura_orange="#ffca85"
      aura_red="#ff6767"
      aura_pink="#f694ff"
      aura_blue="#82e2ff"
      aura_gray="#6d6d6d"

      # Catppuccin-style tmux configuration with Aura colors
      set -g @aura_window_status_style "rounded"
      set -g @aura_status_background "$aura_bg"
      set -g @aura_status_fill "all"
      set -g @aura_window_left_separator ""
      set -g @aura_window_right_separator " "
      set -g @aura_window_middle_separator " █"
      set -g @aura_window_number_position "right"
      set -g @aura_window_default_fill "number"
      set -g @aura_window_default_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}"
      set -g @aura_window_current_fill "number"
      set -g @aura_window_current_text "#{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}#{?window_zoomed_flag,(),}"
      set -g @aura_status_modules_right "directory meetings date_time"
      set -g @aura_status_modules_left "session"
      set -g @aura_status_fill "icon"
      set -g @aura_status_connect_separator "no"
      set -g @aura_directory_text "#{b:pane_current_path}"

      # Status bar styling
      set -g status on
      set -g status-bg "$aura_bg"
      set -g status-fg "$aura_fg"
      set -g status-left-length 100
      set -g status-right-length 100

      # Window status styling with rounded appearance
      set -g window-status-style "fg=$aura_gray,bg=default"
      set -g window-status-current-style "fg=$aura_bg,bg=$aura_purple,bold"
      set -g window-status-activity-style "fg=$aura_bg,bg=$aura_orange"
      set -g window-status-bell-style "fg=$aura_bg,bg=$aura_red"

      # Window status format (Catppuccin-style with rounded separators)
      set -g window-status-format "#[fg=$aura_bg,bg=$aura_gray] #I #[fg=$aura_gray,bg=$aura_bg] #{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}} "
      set -g window-status-current-format "#[fg=$aura_bg,bg=$aura_purple] #I #[fg=$aura_purple,bg=$aura_bg] #{?#{||:#{==:#{pane_current_command},zsh},#{==:#{pane_current_command},bash}},#{b:pane_current_path},#{pane_current_command}}#{?window_zoomed_flag,(),} "

      # Pane borders
      set -g pane-border-style "fg=$aura_gray"
      set -g pane-active-border-style "fg=$aura_purple"

      # Message styling
      set -g message-style "fg=$aura_bg,bg=$aura_purple,bold"
      set -g message-command-style "fg=$aura_bg,bg=$aura_orange,bold"

      # Mode styling (copy mode, etc.)
      set -g mode-style "fg=$aura_bg,bg=$aura_purple,bold"

      # Clock mode
      set -g clock-mode-colour "$aura_green"

      # Status left and right with directory and date_time modules
      set -g status-left "#[fg=$aura_bg,bg=$aura_purple,bold] #S #[fg=$aura_purple,bg=$aura_bg]"
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
