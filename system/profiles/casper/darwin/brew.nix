{...}: {
  homebrew = {
    brews = [
      "gromgit/brewtils/taproom"
      "felixkratz/formulae/borders"
      "dust"
      "btop"
      "PeonPing/tap/peon-ping"
    ];
    taps = [
      "1password/tap"
      "AlexsJones/llmfit"
      "gromgit/brewtils"
      {
        name = "chmouel/lazyworktree";
        clone_target = "https://github.com/chmouel/lazyworktree.git";
      }
    ];
    casks = [
      "arc"
      "1password"
      "1password-cli"
      "hammerspoon"
      "raycast"
      "karabiner-elements"
      "aerospace"
      "ghostty"
      "orbstack"
      "chmouel/lazyworktree/lazyworktree"
    ];
  };
}
