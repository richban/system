{ config, pkgs, ... }: {

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    extraConfig = builtins.readFile ../../dotfiles/yabairc;
  };

  # NOTE:
  # The scripting addition needs root access to load, which we want to do automatically when logging in.
  # This disables the password requirement for it, so that a user-agent can launch it.
  # environment.etc."sudoers.d/yabai-load-sa".text = ''
  #   ${config.user.name} ALL = (root) NOPASSWD: sha256:${builtins.hashFile "sha256" pkgs.yabai.loadScriptingAddition} ${pkgs.yabai.loadScriptingAddition}
  # '';
  #
  # launchd.user.agents.yabai-load-sa = {
  #   path = [ pkgs.yabai config.environment.systemPath ];
  #   command = "/usr/bin/sudo ${pkgs.yabai.loadScriptingAddition}";
  #   serviceConfig = {
  #     RunAtLoad = true;
  #     KeepAlive.SuccessfulExit = true;
  #   };
  # };

  environment.systemPackages = [ pkgs.yabai-zsh-completions ];

  services.skhd.enable = true;
  services.skhd.skhdConfig = builtins.readFile ../../dotfiles/skhdrc;

  services.spacebar = {
    enable = true;
    package = pkgs.spacebar;
    config = {
      position = "bottom";
      display = "all";
      height = 26;
      title = "on";
      spaces = "on";
      clock = "off";
      power = "off";
      padding_left = 20;
      padding_right = 20;
      spacing_left = 25;
      spacing_right = 15;
      text_font = ''"Helvetica Neue:Bold:12.0"'';
      icon_font = ''"Font Awesome 5 Free:Solid:12.0"'';
      background_color = "0xff202020";
      foreground_color = "0xffa8a8a8";
      power_icon_color = "0xffcd950c";
      dnd_icon_color = "0xffa8a8a8";
      power_icon_strip = " ";
      space_icon = "•";
      space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
      spaces_for_all_displays = "on";
      display_separator = "on";
      display_separator_icon = "";
      space_icon_color = "0xff458588";
      space_icon_color_secondary = "0xff78c4d4";
      space_icon_color_tertiary = "0xfffff9b0";
      clock_icon = "";
      dnd_icon = "";
      clock_format = ''"%d/%m/%y %R"'';
      right_shell = "off";
      right_shell_icon = "";
      right_shell_command = "whoami";
    };
  };
}

