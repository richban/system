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
    brews = [];
    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/services"
    ];
    casks = [
      "alacritty"
      "arc"
      "1password"
      "1password-cli"
      "hammerspoon"
      "obsidian"
      "raycast"
      "visual-studio-code"
      "discord"
      "notion"
      "slack"
      "wechat"
      "ticktick"
      "github"
    ];
  };
}
