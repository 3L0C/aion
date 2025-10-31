{config, ...}: let
  hexToRgba = hex: alpha: "rgba(${builtins.substring 1 (-1) hex}${alpha})";
  toRgba = hex: hexToRgba hex "ff";
  toRgbaAlpha = hex: alpha: hexToRgba hex alpha;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 10;
      gaps_out = "25, 20, 25, 20";
      border_size = 4;
      "col.active_border" = toRgba config.themeSpec.border;
      "col.inactive_border" = toRgbaAlpha config.themeSpec.borderInactive "aa";
      resize_on_border = false;
      allow_tearing = false;
      layout = "master";
    };

    decoration = {
      rounding = 8;
      rounding_power = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = false;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = false;

      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
      ];
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
      force_split = 2;
    };
    master = {
      new_status = "master";
      mfact = 0.60;
      new_on_top = true;
      orientation = "left";
      inherit_fullscreen = false;
      smart_resizing = true;
      new_on_active = "before";
    };

    misc = {
      force_default_wallpaper = -1;
      disable_hyprland_logo = true;
      font_family = "Mono";
      enable_swallow = true;
      focus_on_activate = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = false;
    };

    cursor = {
      hide_on_key_press = true;
      inactive_timeout = 5;
      default_monitor = "DP-3";
      no_warps = true;
    };

    binds = {
      drag_threshold = 10;
    };
  };
}
