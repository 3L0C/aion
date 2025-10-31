{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.themeSpec = {
    name = mkOption {
      type = types.str;
      description = "The name of the theme";
    };
    colors = mkOption {
      type = types.submodule {
        options = {
          bg = mkOption {
            type = types.str;
            description = "Primary background";
          };
          bgAlt = mkOption {
            type = types.str;
            description = "Alternative background";
          };
          fg = mkOption {
            type = types.str;
            description = "Primary foreground";
          };
          fgAlt = mkOption {
            type = types.str;
            description = "Alternative foreground";
          };
          base0 = mkOption {type = types.str;};
          base1 = mkOption {type = types.str;};
          base2 = mkOption {type = types.str;};
          base3 = mkOption {type = types.str;};
          base4 = mkOption {type = types.str;};
          base5 = mkOption {type = types.str;};
          base6 = mkOption {type = types.str;};
          base7 = mkOption {type = types.str;};
          base8 = mkOption {type = types.str;};

          grey = mkOption {type = types.str;};
          red = mkOption {type = types.str;};
          orange = mkOption {type = types.str;};
          green = mkOption {type = types.str;};
          teal = mkOption {type = types.str;};
          yellow = mkOption {type = types.str;};
          blue = mkOption {type = types.str;};
          darkBlue = mkOption {type = types.str;};
          magenta = mkOption {type = types.str;};
          violet = mkOption {type = types.str;};
          cyan = mkOption {type = types.str;};
          darkCyan = mkOption {type = types.str;};
        };
      };
      description = "Raw color palette - direct hex color values";
    };

    border = mkOption {
      type = types.str;
      description = "Active window border";
    };
    borderInactive = mkOption {
      type = types.str;
      description = "Inactive window border";
    };
    background = mkOption {
      type = types.str;
      description = "Primary background";
    };
    backgroundAlt = mkOption {
      type = types.str;
      description = "Alternative background";
    };
    foreground = mkOption {
      type = types.str;
      description = "Primary text color";
    };
    foregroundAlt = mkOption {
      type = types.str;
      description = "Secondary text color";
    };
    error = mkOption {
      type = types.str;
      description = "Error state color";
    };
    warning = mkOption {
      type = types.str;
      description = "Warning state color";
    };
    success = mkOption {
      type = types.str;
      description = "Success state color";
    };
    info = mkOption {
      type = types.str;
      description = "Info state color";
    };
    highlight = mkOption {
      type = types.str;
      description = "Highlighted elements";
    };
    selection = mkOption {
      type = types.str;
      description = "Selected items background";
    };
    cursor = mkOption {
      type = types.str;
      description = "Cursor color";
    };
    match = mkOption {
      type = types.str;
      description = "Search match highlight";
    };
    accent = mkOption {
      type = types.str;
      description = "General purpose accent/emphasis color";
    };
    active = mkOption {
      type = types.str;
      description = "Active UI elements (tabs, items, enabled state)";
    };
    urgent = mkOption {
      type = types.str;
      description = "Urgent attention needed (may differ from error)";
    };
    disabled = mkOption {
      type = types.str;
      description = "Disabled/inactive UI elements";
    };
    button = mkOption {
      type = types.str;
      description = "Button color";
    };
    buttonHover = mkOption {
      type = types.str;
      description = "Button hover state";
    };
    menu = mkOption {
      type = types.str;
      description = "Menu background";
    };
    menuSelection = mkOption {
      type = types.str;
      description = "Menu selection background";
    };
    tooltip = mkOption {
      type = types.str;
      description = "Tooltip background";
    };
    barBackground = mkOption {
      type = types.str;
      description = "Status bar background";
    };
    barForeground = mkOption {
      type = types.str;
      description = "Status bar foreground";
    };
    barAccent = mkOption {
      type = types.str;
      description = "Status bar accent color";
    };
    comment = mkOption {
      type = types.str;
      description = "Code comments";
    };
    keyword = mkOption {
      type = types.str;
      description = "Language keywords";
    };
    function = mkOption {
      type = types.str;
      description = "Function names";
    };
    string = mkOption {
      type = types.str;
      description = "String literals";
    };
    variable = mkOption {
      type = types.str;
      description = "Variables";
    };
    constant = mkOption {
      type = types.str;
      description = "Constants";
    };
    type = mkOption {
      type = types.str;
      description = "Type names";
    };
    operator = mkOption {
      type = types.str;
      description = "Operators";
    };
    number = mkOption {
      type = types.str;
      description = "Numeric literals";
    };
    vcsAdded = mkOption {
      type = types.str;
      description = "Added lines in VCS";
    };
    vcsModified = mkOption {
      type = types.str;
      description = "Modified lines in VCS";
    };
    vcsDeleted = mkOption {
      type = types.str;
      description = "Deleted lines in VCS";
    };
    diffAdd = mkOption {
      type = types.str;
      description = "Diff addition background";
    };
    diffChange = mkOption {
      type = types.str;
      description = "Diff change background";
    };
    diffDelete = mkOption {
      type = types.str;
      description = "Diff deletion background";
    };
    terminal = mkOption {
      type = types.submodule {
        options = {
          color0 = mkOption {
            type = types.str;
            description = "Black (normal)";
          };
          color1 = mkOption {
            type = types.str;
            description = "Red (normal)";
          };
          color2 = mkOption {
            type = types.str;
            description = "Green (normal)";
          };
          color3 = mkOption {
            type = types.str;
            description = "Yellow (normal)";
          };
          color4 = mkOption {
            type = types.str;
            description = "Blue (normal)";
          };
          color5 = mkOption {
            type = types.str;
            description = "Magenta (normal)";
          };
          color6 = mkOption {
            type = types.str;
            description = "Cyan (normal)";
          };
          color7 = mkOption {
            type = types.str;
            description = "White (normal)";
          };
          color8 = mkOption {
            type = types.str;
            description = "Black (bright)";
          };
          color9 = mkOption {
            type = types.str;
            description = "Red (bright)";
          };
          color10 = mkOption {
            type = types.str;
            description = "Green (bright)";
          };
          color11 = mkOption {
            type = types.str;
            description = "Yellow (bright)";
          };
          color12 = mkOption {
            type = types.str;
            description = "Blue (bright)";
          };
          color13 = mkOption {
            type = types.str;
            description = "Magenta (bright)";
          };
          color14 = mkOption {
            type = types.str;
            description = "Cyan (bright)";
          };
          color15 = mkOption {
            type = types.str;
            description = "White (bright)";
          };
        };
      };
      description = "Terminal ANSI 16-color palette";
    };
    fonts = mkOption {
      type = types.submodule {
        options = {
          mono = mkOption {
            type = types.str;
            description = "Monospace font family";
          };
          sans = mkOption {
            type = types.str;
            description = "Sans-serif font family";
          };
          serif = mkOption {
            type = types.str;
            description = "Serif font family";
          };
          size = mkOption {
            type = types.int;
            description = "Default font size";
          };
        };
      };
      description = "Font configuration";
    };
  };
}
