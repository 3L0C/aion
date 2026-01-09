{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
in {
  wayland.windowManager.hyprland = {
    settings = {
      env = lib.mapAttrsToList (name: value: "${name},${value}") config.wayland.envVars;

      exec-once = [
        "uwsm finalize"
        "${hyprctl} setcursor ${config.stylix.cursor.name} ${toString config.stylix.cursor.size}"
        "${hyprctl} dispatch workspace 1" # Focus the first workspace on startup
      ];
      general = {
        layout = "master";
        gaps_in = 10;
        gaps_out = "20, 20, 20, 20";
        border_size = 4;
        resize_on_border = false;
        allow_tearing = false;
      };

      xwayland = {
        enabled = true;
        use_nearest_neighbor = true;
        force_zero_scaling = true;
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
        on_focus_under_fullscreen = 0;
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

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        repeat_rate = 50;
        repeat_delay = 300;
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };
      gestures = {
      };

      monitor =
        map (
          m: let
            resolution =
              if m.autoResolution
              then "highres@highrr"
              else "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
          in "${m.name},${resolution},${
            if m.enabled
            then
              "${m.position},${m.scale}"
              + (
                if m.extraArgs != null
                then ",${m.extraArgs}"
                else ""
              )
            else "disable"
          }"
        )
        config.monitors;

      ecosystem = {
        enforce_permissions = true;
      };
      permission = [
        "${lib.escapeRegex (lib.getExe pkgs.grim)}, screencopy, allow"
        "${lib.escapeRegex (lib.getExe pkgs.hyprlock)}, screencopy, allow"
        "${lib.escapeRegex (lib.getExe pkgs.xdg-desktop-portal-hyprland)}, screencopy, allow"
      ];
      workspace = builtins.concatLists (map (m:
        lib.lists.imap0 (
          i: workspace:
            "${workspace},monitor:${m.name}"
            + (
              if i == 0
              then ",default:true"
              else ""
            )
        )
        m.workspaces)
      config.monitors);
      windowrule = [
        "float on, match:class pulsemixer, match:title kitty"
        "center on, match:class pulsemixer, match:title kitty"
        "size 25% 50%, match:class pulsemixer, match:title kitty"
        "workspace 1, match:class ^(LibreWolf)$, match:title ^(Navigator)$"
        "workspace 9, match:class ^(firefox)$, match:title ^(Mozilla Firefox)$"
        "workspace 4, match:class ^(Brave-browser)$"
        "workspace 4, match:class ^(brave-browser)$"
        "workspace 4, match:class ^(Lutris)$"
        "workspace 5, match:class ^(fate.exe)$"
        "float on, match:class ^(fate.exe)$"
        "workspace 5, match:class ^(Steam)$, match:title ^(Steam)$"
        "float on, match:class ^(Steam)$, match:title ^(Friends List)$"
        "workspace 5, match:class ^(Steam)$, match:title ^(Friends List)$"
        "workspace 7, match:class ^(Gimp)$"
        "workspace 10, match:class ^(KeePassXC)$"
        "monitor HDMI-A-1, match:title Picture-in-Picture"
      ];

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };
  };
}
