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
    ];
    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/services"
      "rilldata/tap"
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
      "visual-studio-code"
      "windsurf"
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
    ];
  };
}
