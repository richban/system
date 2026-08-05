{pkgs, ...}: {
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21_headless.home}";
  };

  home.packages = with pkgs; [
    jdk21_headless
    sqlfluff # SQL linter
    (python3Packages.sqlfmt.overrideAttrs (oldAttrs: {
      dontCheckPythonMetadata = true;
    })) # SQL formatter
  ];
}
