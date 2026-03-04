{pkgs, ...}: {
  # ---------------------------------------------------------------------------
  # Packages — ADO-focused; no GitHub-specific tooling
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    git
    git-crypt
    delta
    lazygit # TUI git client, works great with ADO repos
  ];

  home.file.gitignore = {
    source = ../../../dotfiles/gitignore;
    target = ".gitignore";
  };

  # ---------------------------------------------------------------------------
  # Git configuration — Azure DevOps work profile
  # ---------------------------------------------------------------------------
  programs.git = {
    enable = true;
    lfs.enable = true;

    # Pull identity (name + email) from a local file not tracked by this repo.
    # Home-manager writes ~/.config/git/config which includes this path.
    includes = [
      {path = "~/.config/git/identity-work";}
    ];

    settings = {
      # -----------------------------------------------------------------------
      # Identity — update with your work details
      # -----------------------------------------------------------------------
      # Identity is stored outside the repo — never committed.
      # Create ~/.config/git/identity-work on the target machine:
      #
      #   [user]
      #     name  = Your Name
      #     email = you@company.com
      #

      # -----------------------------------------------------------------------
      # Azure DevOps credential setup
      #
      # "least painful" approach: git-credential-store
      #   - On first push/clone to dev.azure.com, git prompts for credentials:
      #       Username: your-work-email (or just press Enter)
      #       Password: your PAT (Personal Access Token)
      #   - Credentials are saved to ~/.git-credentials — never asked again.
      #
      # To generate a PAT:
      #   ADO → User Settings → Personal Access Tokens → New Token
      #   Scope: Code (Read & Write) — or full access if needed
      # -----------------------------------------------------------------------
      credential = {
        helper = "store"; # stores in ~/.git-credentials
      };

      # Required for ADO: scope credentials per-repo path, not per-hostname.
      # Without this a single credential covers ALL projects under dev.azure.com.
      "credential \"https://dev.azure.com\"" = {
        useHttpPath = true;
      };

      # -----------------------------------------------------------------------
      # Aliases — full set, GitHub-specific hub/ghq aliases removed
      # -----------------------------------------------------------------------
      alias = {
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
        # Revert a range of commits
        rv = "!f() { git revert $1^..$2; }; f";
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

        # Generate a .gitignore via gitignore.io
        ignore = "!gi() { curl -sL https://www.toptal.com/developers/gitignore/api/$@ ;}; gi";
      };

      # -----------------------------------------------------------------------
      # General settings — no GitHub-specific options
      # -----------------------------------------------------------------------
      init.defaultBranch = "main";
      color.ui = true;
      commit.verbose = true;
      pull.rebase = true;
      pull.ff = "only";

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

      # -----------------------------------------------------------------------
      # Delta — identical theme to personal config
      # -----------------------------------------------------------------------
      delta = {
        line-numbers = true;
        features = "side-by-side line-numbers decorations";
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
    }; # end settings
  };
}
