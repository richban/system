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
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
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
          rev = "0e810e5afa27acbd074398eefbe28d13005dbc15";
          sha256 = "85aw9OM2pQPsWklXjuNOzp9El1MsNb+cIiZQVHUzBnk=";
        };
      }
      {
        name = "enhancd";
        file = "init.sh";
        src = pkgs.fetchFromGitHub {
          owner = "b4b4r07";
          repo = "enhancd";
          rev = "230695f8da8463b18121f58d748851a67be19a00";
          sha256 = "XJl0XVtfi/NTysRMWant84uh8+zShTRwd7t2cxUk+qU=";
        };
      }
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "449a7c3d095bc8f3d78cf37b9549f8bb4c383f3d";
          sha256 = "3zvOgIi+q7+sTXrT+r/4v98qjeiEL4Wh64rxBYnwJvQ=";
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
