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
      ENHANCD_FILTER = "fzy:fzf:peco";
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
        name = "enhancd";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "v2.5.1";
          sha256 = "XJl0XVtfi/NTysRMWant84uh8+zShTRwd7t2cxUk+qU=";
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

      # Misc
      setopt vi no_beep no_flow_control magic_equal_subst correct

      # Key bindings
      bindkey "^F" forward-word
      bindkey "^B" backward-word
      bindkey "^A" beginning-of-line
      bindkey "^E" end-of-line

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
