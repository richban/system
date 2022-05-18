{ config, pkgs, libs, ... }:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        shellAliases = import ./aliases.nix {pkgs = pkgs;};
        sessionVariables = {};
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
                rev = "v2.2.1";
                sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
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