{
  config,
  pkgs,
  ...
}: {
  home.file.functions = {
    source = ../../dotfiles/functions;
    target = ".functions";
    recursive = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;
    shellAliases = import ./aliases.nix {pkgs = pkgs;};
    sessionVariables = {
      ZSH_HIGHLIGHT_HIGHLIGHTERS = "brackets";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.4.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "c6967f7f70f18991a5f9148996afffc0d3ae76e4";
          sha256 = "p7ZG4NC9UWa55tPxYAaFocc0waIaTt+WO6MNearbO0U=";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "9d003fc02dbaa6db06e6b12e8c271398478e0b5d";
          sha256 = "hwZDbVo50kObLQxCa/wOZImjlH4ZaUI5W5eWs/2RnWg=";
        };
      }
    ];
    initExtra = ''
      setopt histreduceblanks
      setopt histignorespace
      setopt histignorealldups
      setopt autocd
      setopt vi
      setopt no_beep
      setopt globdots
      setopt mark_dirs
      setopt list_packed
      setopt no_flow_control
      setopt auto_param_keys
      setopt auto_list
      setopt auto_menu
      setopt share_history
      setopt auto_param_slash
      setopt magic_equal_subst
      setopt correct

      bindkey "^F" forward-word
      bindkey "^B" backward-word
      bindkey "^A" beginning-of-line
      bindkey "^E" end-of-line

      autopair-init

      . ~/.functions
    '';
    envExtra = ''
      export PATH="$PATH:/usr/local/bin"
      export BEAN_ROOT=~/Developer/richban.ledger
      export ENHANCD_FILTER=fzy:fzf:peco
      export LANGUAGE="en_US.UTF-8"
      export LANG="$LANGUAGE"
      export LC_ALL="$LANGUAGE"
      export LC_CTYPE="$LANGUAGE"
      export GPG_TTY=$(tty)
      export FZF_DEFAULT_OPTS="
      --reverse
      --multi
      --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
      --prompt='∼ ' --pointer='▶' --marker='✓'
      --bind '?:toggle-preview'
      "
    '';
  };
}
