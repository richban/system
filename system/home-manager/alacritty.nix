{...}: let
  config = {
    env = {
      "TERM" = "alacritty";
    };

    window = {
      option_as_alt = "Both";
      padding = {
        x = 10;
        y = 10;
      };
      decorations = "buttonless";
      startup_mode = "Maximized";
      dynamic_title = true;
    };

    scrolling = {
      history = 10000;
      multiplier = 3;
    };

    font = {
      normal = {
        family = "FiraCode Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "FiraCode Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "FiraCode Nerd Font";
        style = "Italic";
      };
      size = 16;
      offset = {
        x = 0;
        y = 0;
      };
      glyph_offset = {
        x = 0;
        y = 0;
      };
    };

    keyboard = {
      bindings = [
        {
          key = "Key0";
          mods = "Command";
          action = "ResetFontSize";
        }
        {
          key = "Equals";
          mods = "Command";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Command";
          action = "DecreaseFontSize";
        }
        {
          key = "V";
          mods = "Command";
          action = "Paste";
        }
        {
          key = "C";
          mods = "Command";
          action = "Copy";
        }
        {
          key = "H";
          mods = "Command";
          action = "Hide";
        }
        {
          key = "Q";
          mods = "Command";
          action = "Quit";
        }
        {
          key = "W";
          mods = "Command";
          action = "Quit";
        }
      ];
    };

    cursor = {
      style = {
        shape = "Block";
        blinking = "On";
      };
      blink_interval = 750;
      blink_timeout = 5;
      unfocused_hollow = true;
    };
  };
in {
  programs.alacritty = {
    enable = true;
    settings = config;
  };
}
