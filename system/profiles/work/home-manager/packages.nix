{pkgs, ...}: {
  # JAVA_HOME points at the headless JDK 17 store path
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk17_headless.home}";
  };

  home.packages = with pkgs; [
    # Java — OpenJDK 17 (headless; no GUI libs, appropriate for a server/WSL env)
    jdk17_headless

    # Azure
    (azure-cli.withExtensions [azure-cli.extensions.azure-devops])

    # Databricks
    (databricks-cli.overrideAttrs (_: {
      doCheck = false;
    }))

    # Hadoop — nixpkgs tracks the latest stable 3.x (see note below)
    # If you need exactly 3.2.2, see the comment at the bottom of this file.
    hadoop

    # CLI Utilities
    jq # JSON processor and formatter
    jiq # Modern Unix `jq`
    fzf # Fuzzy file finder
    fd # Simple find alternative
    ripgrep # Fast text search tool
    tree # Directory structure viewer
    eza # Modern ls replacement
    moreutils # Additional Unix tools
    htop # System monitoring tool
    fastfetch # System info display
    curl # URL transfer tool
    wget # File download utility
    glow # Markdown CLI renderer
    unzip # Archive extraction tool
    gnused # Stream editor
    universal-ctags # Code indexing tool
    pre-commit
    opencode
    zoxide
    ruff # Fast Python linter
    uv # Python package installer
    sqlfluff # SQL linter
    lazygit
    obsidian
    duckdb
    terraform
  ];
}
# ---------------------------------------------------------------------------
# NOTE: Hadoop version pinning
#
# nixpkgs-unstable ships the latest Hadoop 3.x (currently 3.3.x or 3.4.x).
# If your Databricks/Spark jobs require exactly 3.2.2 for client-side
# compatibility (e.g. specific HDFS client behaviour), you have two options:
#
# Option A — override with a specific source hash (add to packages.nix):
#
#   hadoop_322 = pkgs.hadoop.overrideAttrs (old: rec {
#     version = "3.2.2";
#     src = pkgs.fetchurl {
#       url = "mirror://apache/hadoop/common/hadoop-${version}/hadoop-${version}.tar.gz";
#       sha256 = "sha256-<hash>"; # get with: nix-prefetch-url <url>
#     };
#   });
#
# Option B — just use `hadoop` (latest 3.x).
#   For Databricks workloads, the Databricks Runtime manages its own Hadoop
#   internally. The client CLI version rarely needs an exact match.
# ---------------------------------------------------------------------------

