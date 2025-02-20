{
  config,
  pkgs,
  ...
}: {
  home = {
    file.functions = {
      source = ../../dotfiles/functions;
      target = ".functions";
      recursive = true;
    };
    sessionVariables = {
      TERM = "xterm-256color";
      LANG = "en_US.UTF-8";
      GPG_TTY = "/dev/ttys000";
      PATH = "${config.home.homeDirectory}/.local/bin:/opt/homebrew/bin:$PATH";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = import ./aliases.nix {inherit pkgs;};

    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "449a7c3d095bc8f3d78cf37b9549f8bb4c383f3d";
          sha256 = "3zvOgIi+q7+sTXrT+r/4v98qjeiEL4Wh64rxBYnwJvQ=";
        };
      }
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "enhancd";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "5afb4eb6ba36c15821de6e39c0a7bb9d6b0ba415";
          sha256 = "sha256-pKQbwiqE0KdmRDbHQcW18WfxyJSsKfymWt/TboY2iic=";
        };
        file = "init.sh";
      }
    ];

    initExtra = ''
      # History
      setopt histreduceblanks histignorespace histignorealldups share_history

      # Directory navigation
      setopt autocd globdots mark_dirs

      # Completion
      setopt auto_list auto_menu auto_param_keys auto_param_slash list_packed

      # fzf-tab configuration
      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      zstyle ':completion:*:descriptions' format '[%d]'
      # preview directory's content with exa when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      # switch group using `,` and `.`
      zstyle ':fzf-tab:*' switch-group ',' '.'
      # show file preview for files and directories
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 {}'

      # Misc
      setopt vi no_beep no_flow_control magic_equal_subst correct

      # Key bindings
      bindkey "^F" forward-word
      bindkey "^B" backward-word
      bindkey "^A" beginning-of-line
      bindkey "^E" end-of-line

      # fzf key bindings (Option key should work now)
      bindkey "^[d" fzf-cd-widget       # Option+d for directory search
      bindkey "^R" fzf-history-widget   # CTRL+R for history

      # Configure fzf history widget
      export FZF_CTRL_R_OPTS="--height=40% --layout=reverse --border --ansi"

      autopair-init

      # Source custom functions
      . ~/.functions
    '';

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
