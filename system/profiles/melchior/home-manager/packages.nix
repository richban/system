{pkgs, ...}: {
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21_headless.home}";
  };

  home.packages = with pkgs; [
    gemini-cli # Gemini CLI
    # inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.claude-code # Claude CLI from Nix flake

    # Infrastructure & Containers
    terraform # Infrastructure as code
    # google-cloud-sdk # GCP toolkit
    awscli # AWS Command Line Interface
    sqlfluff # SQL linter

    jdk21_headless

    # fabric-ai
    # yt-dlp
  ];
}
