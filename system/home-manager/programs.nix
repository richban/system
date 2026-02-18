{pkgs, ...}: {
  programs.vscode.enable = true;

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batwatch
      prettybat
      batman
    ];
    config = {
      style = "plain";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--info=inline"
    ];

    fileWidgetOptions = [
      "--preview 'bat --color=always --plain {}'"
    ];

    changeDirWidgetOptions = [
      "--preview 'eza -l --tree --level=2 --color=always {}'"
    ];

    historyWidgetOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
      "--ansi"
      # Process command with syntax highlighting
      "--preview 'echo {} | bat --color=always --plain --language=sh'"
      "--preview-window=:hidden"
    ];
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vicmd_symbol = "[V](bold green) ";
      };

      cmd_duration = {
        format = "[  $duration]($style)";
        min_time = 2500;
        min_time_to_notify = 60000;
        show_notifications = false;
        style = "fg:base";
      };
    };
  };

  programs.bottom = {
    enable = true;
    settings = {
      disk_filter = {
        is_list_ignored = true;
        list = ["/dev/loop"];
        regex = true;
        case_sensitive = false;
        whole_word = false;
      };
      flags = {
        dot_marker = false;
        enable_gpu_memory = true;
        group_processes = true;
        hide_table_gap = true;
        mem_as_value = true;
        tree = true;
      };
    };
  };

  programs.tealdeer = {
    enable = true;
    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {auto_update = true;};
    };
  };
}
