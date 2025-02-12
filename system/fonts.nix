{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.symbols-only
      font-awesome
    ];
  };
}