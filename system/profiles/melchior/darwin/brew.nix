{...}: {
  homebrew = {
    brews = [
      "gromgit/brewtils/taproom"
      "felixkratz/formulae/borders"
      "gnuplot"
      "graphviz"
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
      "nikitabobko/tap"
      "FelixKratz/formulae"
      "AlexsJones/llmfit"
      "gromgit/brewtils"
      {
        name = "chmouel/lazyworktree";
        clone_target = "https://github.com/chmouel/lazyworktree.git";
      }
    ];
    casks = [
      "arc"
      "firefox"
      "1password"
      "1password-cli"
      "hammerspoon"
      "obsidian"
      "raycast"
      "discord"
      "notion"
      "slack"
      "wechat"
      "github"
      "karabiner-elements"
      "zoom"
      "whatsapp"
      "microsoft-teams"
      "aerospace"
      "ghostty"
      "orbstack"
      "chmouel/lazyworktree/lazyworktree"
    ];
  };
}
