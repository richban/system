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
    initExtra = lib.mkIf pkgs.stdenvNoCC.isDarwin ''
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
      key = null;
      signer =
        if pkgs.stdenvNoCC.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "${pkgs._1password-gui}/share/1password/op-ssh-sign";
    };
    extraConfig = {
      gpg.format = "ssh";
      gpg.ssh = {
        defaultKeyCommand = "op read 'op://Personal/Github Signing Key/public key'";
        # allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  };
}
