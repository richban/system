{...}: {
  homebrew = {
    brews = [
      "gromgit/brewtils/taproom"
      "felixkratz/formulae/borders"
      "dust"
      "btop"
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
      # "1password"
      "1password-cli"
      # "hammerspoon"
      "raycast"
      "karabiner-elements"
      "aerospace"
      "ghostty"
      "orbstack"
      "chmouel/lazyworktree/lazyworktree"
      "openlogi"
    ];
  };
}
