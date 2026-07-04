{pkgs, ...}: {
  home.packages = with pkgs; [
    sqlfluff # SQL linter
  ];
}
