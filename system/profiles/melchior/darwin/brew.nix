{...}: {
  homebrew = {
    brews = [
      "gromgit/brewtils/taproom"
      "gnuplot"
      "graphviz"
      "dust"
      "btop"
      "chafa"
      "csvlens"
      "PeonPing/tap/peon-ping"
    ];
    taps = [
      {
        name = "1password/tap";
        trusted = true;
      }
      {
        name = "AlexsJones/llmfit";
        trusted = true;
      }
      {
        name = "felixkratz/formulae";
        trusted = true;
      }
      {
        name = "gromgit/brewtils";
        trusted = true;
      }
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
      {
        name = "PeonPing/tap";
        trusted = true;
      }
      {
        name = "chmouel/lazyworktree";
        clone_target = "https://github.com/chmouel/lazyworktree.git";
        trusted = true;
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
      "openlogi"
    ];
  };
}
