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
      "peonping/tap/peon-ping"
    ];
    taps = [
      {
        name = "1password/tap";
        trusted = true;
      }
      {
        name = "alexsjones/llmfit";
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
        name = "peonping/tap";
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
