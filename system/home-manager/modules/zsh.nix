{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    file.functions = {
      source = ../../../dotfiles/functions;
      target = ".functions";
      recursive = true;
    };
    sessionVariables = {
      TERM = "xterm-256color";
      LANG = "en_US.UTF-8";
      GPG_TTY =
        if pkgs.stdenv.isDarwin
        then "/dev/ttys000"
        else "/dev/tty";
      PATH = "${config.home.homeDirectory}/.local/bin${lib.optionalString pkgs.stdenv.isDarwin ":/opt/homebrew/bin"}:$PATH";
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

    initContent = ''
      # Aura Theme Colors
      export LS_COLORS="di=1;94:fi=0;97:ln=1;96:pi=40;33:so=1;95:bd=40;33;1:cd=40;33;1:or=1;31:ex=1;92:*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.gz=1;31:*.bz2=1;31:*.deb=1;31:*.rpm=1;31:*.jar=1;31"

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

      # Configure fzf with Aura theme colors
      export FZF_DEFAULT_OPTS="--color=bg+:#29263c,bg:#15141b,border:#a277ff,spinner:#61ffca,hl:#a277ff,fg:#edecee,header:#a277ff,info:#ffca85,pointer:#61ffca,marker:#ff6767,fg+:#edecee,prompt:#a277ff,hl+:#a277ff,scrollbar:#4d4d4d,separator:#4d4d4d --layout=reverse"
      export FZF_CTRL_R_OPTS="--height=40% --layout=reverse --border --ansi"

      autopair-init
      eval "$(zoxide init zsh)"

      # Source custom functions
      . ~/.functions

      # Fabric AI patterns integration
      # Set Obsidian directory for Fabric output
      export OBSIDIAN_PATH="$HOME/Developer/second-brain"

      # Function to create Fabric pattern aliases dynamically
      create_fabric_aliases() {
        if [[ -d "$HOME/.config/fabric/patterns" ]]; then
          for pattern in "$HOME/.config/fabric/patterns"/*; do
            if [[ -d "$pattern" ]]; then
              pattern_name=$(basename "$pattern")
              # Create alias that saves output to Obsidian in markdown format
              alias "f_$pattern_name"="fabric --pattern $pattern_name | tee \"\$OBSIDIAN_PATH/fabric-\$pattern_name-\$(date +%Y%m%d-%H%M%S).md\""
              # Create alias without file saving for quick use
              alias "$pattern_name"="fabric --pattern $pattern_name"
            fi
          done
          echo "Fabric aliases created for $(ls ~/.config/fabric/patterns | wc -l | tr -d ' ') patterns"
        else
          echo "Fabric patterns not found. Run 'fabric --setup' first."
        fi
      }

      # Function to list all available Fabric patterns
      list_fabric_patterns() {
        if [[ -d "$HOME/.config/fabric/patterns" ]]; then
          echo "Available Fabric patterns:"
          ls -1 "$HOME/.config/fabric/patterns" | sed 's/^/  • /'
          echo "\nUsage:"
          echo "  pattern_name       - Run pattern and display output"
          echo "  f_pattern_name     - Run pattern and save to Obsidian markdown"
        else
          echo "Fabric patterns not found. Run 'fabric --setup' first."
        fi
      }

      # Create aliases when shell starts
      create_fabric_aliases
    '';

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
