{
  config,
  lib,
  ...
}: {
  nix-homebrew.trust = {
    taps = map (t: lib.toLower t.name) (builtins.filter (t: t.trusted) config.homebrew.taps);
  };

  homebrew = {
    enable = true;
    global = {
      brewfile = true;
    };
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}
