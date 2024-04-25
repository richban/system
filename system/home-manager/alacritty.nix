{...}: let
  colorscheme = import ../colorschemes/dracula.nix;
  config = {colors}: {
    env = {
      "TERM" = "alacritty";
    };

    selection = {
      semantic_escape_chars = ",│`|:\"' ()[]{}<>\t";

      # When set to `true`, selected text will be copied to the primary clipboard.
      save_to_clipboard = true;
    };

    window = {
      # Window dimensions (changes require restart)
      #
      # Specified in number of columns/lines, not pixels.
      # If both are `0`, this setting is ignored.
      # dimensions = {
      #   columns = 200;
      #   lines = 60;
      # };

      # Window padding (changes require restart)
      #
      # Blank space added around the window in pixels. This padding is scaled
      # by DPI and the specified value is always added at both opposing sides.
      padding = {
        x = 5;
        y = 5;
      };
      dynamic_padding = false;

      # Window decorations
      #
      # Available values:
      # - `full`: Window with title bar and title bar buttons
      # - `none`: Window without title bar, rounded corners, or drop shadow
      # - `transparent`: Window with title bar with transparent background and title
      #   bar buttons
      # - `buttonless`: Window with title bar with transparent background and no
      #   title bar buttons
      # decorations = "full";
    };

    font = {
      size = 16;

      normal.family = "FiraCode Nerd Font";
      normal.style = "Regular";
      bold.family = "FiraCode Nerd Font";
      bold.style = "Bold";
      italic.family = "FiraCode Nerd Font";
      italic.style = "Italic";
      bold_italic.family = "FiraCode Nerd Font";
      bold_italic.style = "Bold Italic";
    };

    # Cursor style
    #
    # Values for 'style':
    #   - ▇ Block
    #   - _ Underline
    #   - | Beam
    cursor = {
      style = "Block";
      unfocused_hollow = true;
    };

    # Shell
    #
    # You can set `shell.program` to the path of your favorite shell, e.g. `/bin/fish`.
    # Entries in `shell.args` are passed unmodified as arguments to the shell.
    #   shell = {
    #     program = "/home/sherub/.nix-profile/bin/nu";
    #   };

    import = ["~/.config/alacritty/catppuccin/catppuccin-mocha.toml"];

    keyboard = {
      bindings = [
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
          key = "Paste";
          action = "Paste";
        }
        {
          key = "Copy";
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
        {
          key = "LBracket";
          mods = "Command";
          chars = "\x5c\x70";
        }
        # Use command + ] - to go to previous tmux window
        {
          key = "RBracket";
          mods = "Command";
          chars = "\x5c\x6e";
        }
        # ctrl-^ doesn't work in some terminals like alacritty
        # { key = "Key6"; mods = "Control"; chars = "\x1e"; }
        {
          key = "Plus";
          mods = "Command";
          action = "IncreaseFontSize";
        }
        {
          key = "Minus";
          mods = "Command";
          action = "DecreaseFontSize";
        }
        {
          key = "Key0";
          mods = "Command";
          action = "ResetFontSize";
        }
        {
          key = "F";
          mods = "Command|Control";
          action = "ToggleFullscreen";
        }
      ];
    };
  };
in {
  programs.alacritty = {
    enable = true;
    settings = config {colors = colorscheme;};
  };
}
