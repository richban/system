{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    git-crypt
    gitAndTools.delta
    act
    github-cli
    git-igitt # Modern Unix git log/graph
  ];

  home.file.gitignore = {
    source = ../../dotfiles/gitignore;
    target = ".gitignore";
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
      gh-markdown-preview
    ];
    settings = {
      editor = "nvim";
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.gitui = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "richban";
    userEmail = "rbanyi@me.com";

    lfs.enable = true;

    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      # Add files to the staging area
      a = "add";
      # Add all changes to the staging area
      aa = "add --all";
      # Add changes interactively
      ap = "add --patch";
      # Add selected files using fzf
      af = "!git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 git add";
      # Unstage selected files using fzf
      au = "!git diff --name-only --cached | fzf -m --print0 | xargs -0 git restore --staged";

      # Branch management
      b = "branch";
      # List all branches with verbose
      ba = "branch -av";
      # Delete a branch
      bd = "branch -d";
      # Rename a branch
      bm = "branch -m";
      # Force delete selected branches using fzf
      bdf = "!git branch | fzf -m --print0 | tr -d ' ' | xargs -0 git branch -D";

      # Checkout branches and files
      co = "checkout";
      # Create and checkout a new branch
      cob = "checkout -b";
      # Checkout selected branch using fzf
      coc = "!git branch | fzf | xargs git checkout";
      # Checkout selected files using fzf
      cof = "!git ls-files -m -o --exclude-standard | fzf -m --print0 | xargs -0 git checkout";

      # Commit changes
      c = "commit";
      # Commit verbosely
      cv = "commit --verbose";
      # Amend the last commit without editing the message
      ca = "commit --amend --no-edit";
      # Commit all changes
      caa = "commit --all";
      # Amend the last commit with editing
      car = "commit --amend";
      # Create a fixup commit
      cx = "commit --fixup";

      # Clean untracked files and directories
      cl = "clean -fd";

      # Cherry-pick commits
      cp = "cherry-pick";
      # Abort the current cherry-pick
      cpa = "cherry-pick --abort";
      # Continue the current cherry-pick
      cpc = "cherry-pick --continue";
      # Cherry-pick without committing
      cpn = "cherry-pick --no-commit";

      # Show differences
      d = "diff";
      # Show differences from HEAD
      dh = "diff HEAD";
      # Show staged differences
      ds = "diff --staged";
      # Show cached differences
      dc = "diff --cached";
      # Show differences from origin to current branch
      dr = "!git diff origin $(git rev-parse --abbrev-ref HEAD)";
      # Use difftool to show differences
      dt = "difftool";

      # Delete merged remote branches except main and develop
      del = "!git branch -r --merged | grep -v 'main\\|develop' | sed 's/origin\\///' | xargs -n 1 git push --delete origin && git fetch origin --prune";

      # Fetch changes from the remote repository
      f = "fetch";
      # Fetch changes and prune deleted branches
      fp = "fetch -p";

      # Show commit logs
      lg = "log --stat";
      # Show graphical commit log
      lgg = "!git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      # Show commit log with fzf preview
      lgs = "!git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit | fzf --preview 'echo {} | cut -f1 -d\" \" | xargs git show --color'";
      # Show commit log with patches
      lgp = "log -p";

      # Merge branches
      m = "merge --log";
      # Abort the current merge
      ma = "merge --abort";
      # Continue the current merge
      mc = "merge --continue";
      # Merge without fast-forwarding
      mf = "merge --log --no-ff";
      # Only fast-forward merge
      mff = "merge --ff-only";
      # Use mergetool to resolve conflicts
      mt = "mergetool";

      # Browse repositories using hub
      op = "!hub browse";
      # Browse selected repository using fzf
      opg = "!hub browse $(ghq list | fzf | cut -d '/' -f 2,3)";
      # Show selected issue using hub
      opi = "!hub issue show $(hub issue | fzf)";
      # Show selected pull request using hub
      opp = "!hub pr show $(hub pr list | fzf)";
      # Browse selected repository using hub and jq
      opr = "!hub api --paginate -XGET user/repos -f affiliation=owner -f per_page=100 | jq -r '.[].name' | fzf | xargs hub browse";
      # Browse selected gist using hub and jq
      opt = "!hub api --paginate -XGET gists -f affiliation=owner -f per_page=100 | jq -r '.[] | \"\\(.files | keys[]) \\(.id)\"' | fzf | awk -F' ' '{print $NF}' | xargs -I{} open -a 'Google Chrome' https://gist.github.com/ulwlu/{}";

      # Show the status of the working directory
      s = "status";

      # Stash changes
      sts = "stash --save";
      # Clear the stash
      stc = "stash --clear";
      # List stashes with fzf preview
      stl = "!git stash list | awk -F':' '{print $1}' | fzf --preview 'git -c color.ui=always stash show -p {}'";
      # Pop selected stash using fzf
      stp = "!git stash pop $(git stash list | awk -F':' '{print $1}' | fzf --preview 'git -c color.ui=always stash show -p {}')";
      # Drop selected stash using fzf
      std = "!git stash drop $(git stash list | awk -F':' '{print $1}' | fzf --preview 'git -c color.ui=always stash show -p {}')";

      # Rebase branches
      rb = "rebase";
      # Abort the current rebase
      rba = "rebase --abort";
      # Continue the current rebase
      rbc = "rebase --continue";
      # Start an interactive rebase
      rbi = "rebase --interactive";

      # Reset changes
      rs = "reset";
      # Reset and keep changes
      rsk = "reset --keep";
      # Reset with mixed mode
      rsm = "reset --mixed";
      # Hard reset
      rsh = "reset --hard";

      # Pull changes from the remote repository
      pl = "pull";
      # Pull changes with rebase
      plr = "pull --rebase";
      # Pull changes for the current branch
      pll = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";

      # Push changes to the remote repository
      ps = "push";
      # Force push changes
      psf = "push --force";
      # Push changes for the current branch
      pss = "!git push origin $(git rev-parse --abbrev-ref HEAD)";

      # Find the first merge commit between a branch and main
      pr = "!f() { git log --merges --oneline --reverse --ancestry-path $1...main | grep 'Merge pull request' | head -n 1; }; f";
      # Add a forked remote repository
      ra = "!f() { echo $1 | sed 's/https/git/g' | sed 's/$/.git/g' | xargs git remote add forked }; f";
      # Show the reflog
      rf = "reflog --format='%C(auto)%h %<|(20)%gd %C(blue)%ci%C(reset) %gs (%s)'";
      # Reset to selected reflog entry using fzf
      rfs = "!git reflog --format='%C(auto)%h %<|(20)%gd %C(blue)%ci%C(reset) %gs (%s)' | awk -F' ' '{print $2}' | xargs git reset --hard";
      # Remove selected repositories using fzf
      rmg = "!ghq list -p | fzf -m --print0 | xargs -0 rm -rf";
      # Revert a range of commits
      rv = "!f() { git revert $1^..$2; }; f";
      # Scan history for secrets
      sca = "secrets --scan-history";
      # Skip worktree for a file
      sk = "update-index --skip-worktree";
      # Unskip worktree for a file
      usk = "update-index --no-skip-worktree";
      # Edit the Git configuration file
      vi = "!nvim ~/.gitconfig";
      # Install Git LFS
      lf = "!git lfs install";
      # Uninstall Git LFS and recommit files
      ulf = "!git lfs uninstall && touch **/* && git commit -a";

      ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
    };
    extraConfig = {
      init.defaultBranch = "main";
      github.user = "richban";
      color.ui = true;
      commit.verbose = true;
      pull.rebase = true;
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

      push = {
        autoSetupRemote = true;
      };

      "difftool \"vimdiff\"" = {
        path = "nvim";
      };

      delta = {
        line-numbers = true;
        features = "side-by-side line-numbers decorations";
        # Muted Aura theme colors for better readability
        plus-style = "syntax #4a9d7a";
        minus-style = "syntax #c75757";
        plus-emph-style = "syntax #4a9d7a bold";
        minus-emph-style = "syntax #c75757 bold";
        line-numbers-plus-style = "#4a9d7a";
        line-numbers-minus-style = "#c75757";
        line-numbers-zero-style = "#6d6d6d";
        syntax-theme = "Monokai Extended";
        file-style = "bold #a277ff";
        file-decoration-style = "#ffca85";
        hunk-header-style = "file line-number syntax";
        hunk-header-decoration-style = "#ffca85 box";
        true-color = "always";
      };

      "delta \"decorations\"" = {
        commit-decoration-style = "bold #ffca85 box ul";
        file-style = "bold #a277ff";
        file-decoration-style = "#ffca85";
      };
    };
  };
}
