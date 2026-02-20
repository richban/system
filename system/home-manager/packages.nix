{
  inputs,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk21_headless.home}";
  };

  home.packages = with pkgs; [
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
    neofetch # System info display
    curl # URL transfer tool
    wget # File download utility
    glow # Markdown CLI renderer
    unzip # Archive extraction tool
    gnused # Stream editor
    universal-ctags # Code indexing tool
    gemini-cli # Gemini CLI

    # Development Tools
    lua # Lua programming language
    readline # Line editing library
    shellcheck # Shell script analyzer
    graphviz # Graph visualization
    treefmt # Code formatter
    shfmt # Shell formatter
    pre-commit # Git hooks manager
    git-sizer # Git repo analyzer
    git-lfs # Git large file storage
    inputs.claude-code.packages.${pkgs.stdenv.hostPlatform.system}.claude-code # Claude CLI from Nix flake
    fpp # Fuzzy path picker
    zoxide

    # Ruby Environment
    (pkgs.ruby.withPackages (ps: with ps; [jekyll]))

    # Java
    jdk21_headless

    # Infrastructure & Containers
    terraform # Infrastructure as code
    google-cloud-sdk # GCP toolkit
    awscli # AWS Command Line Interface

    nixfmt # Nix code formatter
    nixpkgs-review # Nix code review
    nix-prefetch-scripts # Nix code fetcher
    nurl # Nix URL fetcher

    # Python Environment
    # (pkgs.python311.withPackages (ps:
    #   with ps; [
    #     duckdb # SQL database engine
    #     pandas # Data analysis library
    #     polars # Fast dataframe library
    #     jupyter # Interactive notebooks
    #     ipython # Enhanced Python shell
    #   ]))
    # duckdb # SQL database engine
    cookiecutter # Project template tool
    ruff # Fast Python linter
    uv # Python package installer
    sqlfluff # SQL linter

    # Node.js Environment
    nodejs_22 # Node.js 22 (LTS)
    # nodePackages.npm # Node package manager

    asciicam # Terminal webcam
    bandwhich # Modern Unix `iftop`
    cpufetch # Terminal CPU info
    difftastic # Modern Unix `diff`
    fastfetch # Modern Unix system info
    ipfetch # Terminal IP info
    fabric-ai
    # yt-dlp
  ];
}
