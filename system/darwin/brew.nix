{...}: {
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    brews = [];
    taps = [
      "1password/tap"
      "homebrew/bundle"
      "homebrew/services"
      "koekeishiya/formulae"
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
      "dropbox"
      "notion"
      "signal"
      "slack"
      "wechat"
      "ticktick"
      "github"
    ];
  };
}
