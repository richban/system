{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    git-crypt
    gitAndTools.delta
  ];

  home.file.gitignore = {
    source = ../../dotfiles/gitignore;
    target = ".gitignore";
  };

  programs.git = {
    enable = true;
    userName = "richban";
    userEmail = "rbanyi@me.com";

    lfs.enable = true;

    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      github.user = "richban";
      color.ui = true;
      pull.ff = "only";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";

      core = {
        pager = "delta";
        excludesfile = "~/.gitignore";
        quotepath = false;
        autocrlf = "input";
        safecrlf = "warn";
        editor = "nvim";
      };

      diff = {
        prompt = false;
        tool = "vimdiff";
        algorithm = "histogram";
      };

      "difftool \"vimdiff\"" = {
        path = "nvim";
      };

      delta = {
        line-numbers = true;
        features = "side-by-side line-numbers decorations";
      };

      gpg = {
        format = "ssh";
      };

      "delta \"decorations\"" = {
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow";
        file-decoration-style = "none";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.gpg.enable = true;
  services.gpg-agent.enable = pkgs.stdenv.isLinux;
}
