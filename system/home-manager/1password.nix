{
  config,
  lib,
  pkgs,
  ...
}: let
  homePath = config.home.homeDirectory;
  darwinSockPath = "${homePath}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  sockLink = ".1password/agent.sock";
  sockPath = "${homePath}/${sockLink}";
  aliases = {
    gh = "op plugin run -- gh";
    cachix = "op plugin run -- cachix";
  };
in {
  home.sessionVariables = {
    SSH_AUTH_SOCK =
      if pkgs.stdenvNoCC.isDarwin
      then sockPath
      else ''''${SSH_AUTH_SOCK:-${sockPath}}'';
    OP_PLUGIN_ALIASES_SOURCED = 1;
  };

  home.file.sock = lib.mkIf pkgs.stdenvNoCC.isDarwin {
    source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
    target = sockLink;
  };

  programs.zsh = {
    initContent = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
      if command -v op >/dev/null; then
        eval "$(op completion zsh)"; compdef _op op
      fi
    '';
    shellAliases = aliases;
  };

  programs.ssh = {
    enable = true;
    extraConfig = "IdentityAgent ${sockPath}";
  };

  xdg.configFile = {
    opAgent = {
      recursive = true;
      target = "1Password/ssh/agent.toml";
      text = ''
        [[ssh-keys]]
        vault = "Personal"
      '';
    };
  };

  programs.git = {
    signing = {
      signByDefault = true;
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6/erFt5q36JNuiFG4FqiYE3flwgqyVL0FawLSSuPW8";
      signer =
        if pkgs.stdenvNoCC.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "${pkgs._1password-gui}/share/1password/op-ssh-sign";
    };
    settings = {
      gpg.format = "ssh";
      gpg.ssh = {
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        # allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  };
}
