{...}: {
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "uninstall";
    };
    brews = [
      "gromgit/brewtils/taproom"
      "terminal-notifier"
      "rilldata/tap/rill"
      "felixkratz/formulae/borders"
      "gnuplot"
      "graphviz"
      "databricks"
      "opencode"
      "dust"
      "btop"
      "chafa"
      "csvlens"
      "PeonPing/tap/peon-ping"
    ];
    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/services"
      "rilldata/tap"
      "nikitabobko/tap"
      "FelixKratz/formulae"
      "databricks/tap"
      "AlexsJones/llmfit"
      "gromgit/brewtils"
      {
        name = "chmouel/lazyworktree";
        clone_target = "https://github.com/chmouel/lazyworktree.git";
      }
    ];
    casks = [
      # "alacritty"
      "arc"
      "firefox"
      "1password"
      "1password-cli"
      # "docker-desktop"
      "hammerspoon"
      "obsidian"
      "raycast"
      "discord"
      "notion"
      "slack"
      "wechat"
      # "ticktick"
      "github"
      "karabiner-elements"
      "zoom"
      "whatsapp"
      "microsoft-teams"
      "aerospace"
      # "godot"
      "ghostty"
      "orbstack"
      "chmouel/lazyworktree/lazyworktree"
    ];
  };
}
