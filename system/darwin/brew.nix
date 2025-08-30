{...}: {
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      "terminal-notifier"
      "rilldata/tap/rill"
      "felixkratz/formulae/borders"
      "gnuplot"
      "graphviz"
    ];
    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/services"
      "rilldata/tap"
      "nikitabobko/tap"
      "FelixKratz/formulae"
    ];
    casks = [
      "alacritty"
      "arc"
      "firefox"
      "1password"
      "1password-cli"
      "docker"
      "hammerspoon"
      "obsidian"
      "raycast"
      "discord"
      "notion"
      "slack"
      "wechat"
      "ticktick"
      "github"
      "karabiner-elements"
      "zoom"
      "whatsapp"
      "microsoft-teams"
      "aerospace"
      "godot"
    ];
  };
}
