{lib, ...}: let
  inherit (lib) mkOption types;
  fontType = types.submodule {
    options = {
      package = mkOption {
        type = types.package;
        description = "Font package";
      };
      name = mkOption {
        type = types.str;
        description = "Font name as recognized by fontconfig";
      };
    };
  };
in {
  options.userSpec = {
    # Keyboard options
    kbdModel = mkOption {
      type = types.str;
      description = "Keyboard model";
      default = "pc105";
    };
    kbdLayout = mkOption {
      type = types.str;
      description = "Keyboard layout";
      default = "us";
    };
    kbdVariant = mkOption {
      type = types.str;
      description = "Keyboard variant";
      default = "";
    };
    kbdOptions = mkOption {
      type = types.str;
      default = "";
      description = "XKB keyboard options (e.g., caps:swapescape)";
      example = "caps:swapescape,compose:ralt";
    };

    # Compositor modifier keys (different compositors use different syntax)
    modifierKeys = mkOption {
      type = types.attrsOf types.str;
      default = {
        river = "Super";
        hyprland = "SUPER";
        niri = "Mod";
      };
      description = ''
        Modifier key(s) for window manager keybindings, per compositor.
        Different compositors use different syntax:
        - River: "Super", "Super+Control", "Shift+Control+Alt"
        - Hyprland: "SUPER", "SUPER_CONTROL", "SUPER_SHIFT"
        - Niri: "Mod", "Mod+Shift", "Mod+Ctrl" (Mod = Super on TTY, Alt in window)
      '';
      example = {
        river = "Super+Control";
        hyprland = "SUPER_CONTROL";
        niri = "Mod+Ctrl";
      };
    };

    # Kmonad options
    kmonadDevice = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Input device path for kmonad (e.g., /dev/input/event5)";
      example = "/dev/input/event5";
    };
    kmonadConfig = mkOption {
      type = types.nullOr types.lines;
      default = null;
      description = "Kmonad configuration content (.kbd file content)";
    };

    # Theme/Stylix options
    theme = {
      base16Scheme = mkOption {
        type = types.str;
        default = "kanagawa-abyss";
        description = "Base16 color scheme name (from base16-schemes package)";
        example = "gruvbox-dark-medium";
      };

      polarity = mkOption {
        type = types.enum ["dark" "light"];
        default = "dark";
        description = "Theme polarity";
      };

      wallpaper = mkOption {
        type = types.path;
        description = "Path to wallpaper image";
      };
    };

    # Cursor options
    cursor = {
      package = mkOption {
        type = types.package;
        description = "Cursor theme package";
      };
      name = mkOption {
        type = types.str;
        default = "phinger-cursors-dark";
        description = "Cursor theme name";
      };
      baseSize = mkOption {
        type = types.int;
        default = 24;
        description = "Base cursor size before display scaling";
      };
    };

    # Font options
    fonts = {
      emoji = mkOption {
        type = fontType;
        description = "Emoji font";
      };
      monospace = mkOption {
        type = fontType;
        description = "Monospace font for terminals and code";
      };
      sansSerif = mkOption {
        type = fontType;
        description = "Sans-serif font for UI";
      };
      serif = mkOption {
        type = fontType;
        description = "Serif font";
      };
      sizes = {
        applications = mkOption {
          type = types.int;
          default = 14;
          description = "Font size for applications";
        };
        desktop = mkOption {
          type = types.int;
          default = 14;
          description = "Font size for desktop elements";
        };
        popups = mkOption {
          type = types.int;
          default = 14;
          description = "Font size for popups and notifications";
        };
        terminal = mkOption {
          type = types.int;
          default = 16;
          description = "Font size for terminal";
        };
      };
    };

    # Icon options
    icons = {
      package = mkOption {
        type = types.package;
        description = "Icon theme package";
      };
      dark = mkOption {
        type = types.str;
        default = "Papirus-Dark";
        description = "Dark icon theme name";
      };
      light = mkOption {
        type = types.str;
        default = "Papirus-Light";
        description = "Light icon theme name";
      };
    };

    # Opacity options
    opacity = {
      applications = mkOption {
        type = types.float;
        default = 1.0;
        description = "Opacity for applications (0.0-1.0)";
      };
      desktop = mkOption {
        type = types.float;
        default = 1.0;
        description = "Opacity for desktop elements";
      };
      popups = mkOption {
        type = types.float;
        default = 1.0;
        description = "Opacity for popups";
      };
      terminal = mkOption {
        type = types.float;
        default = 1.0;
        description = "Opacity for terminal";
      };
    };
  };
}
