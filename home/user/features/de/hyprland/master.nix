{
  lib,
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = [
        "DP-3, highres@highrr, 0x0, 1"
        "HDMI-A-1, highres@highrr, 2560x0, 1"
      ];
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # Programs
      "$terminal" = "uwsm app -- kitty";
      "$fileManager" = "uwsm app -- lf";
      "$menu" = "uwsm app -- rofi -show drun -monitor \"$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')\"";
      "$browser" = "uwsm app -- firefox";
      "$mainMod" = "SUPER";
      "$mehMod" = "SHIFT ALT CTRL";
      exec-once = [
        "uwsm app -- dunst"
        "hyprctl setcursor phinger-cursors-dark 24"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "uwsm app -- dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment QT_QPA_PLATFORMTHEME"
        "uwsm app -- waybar"
        "uwsm app -- tmux new-session -s x-server -d &"
        "uwsm app -- setsid -f wpctl-settings"
        "uwsm app -- mpd &"
      ];
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

      general = {
        gaps_in = 10;
        gaps_out = "25, 20, 25, 20";
        border_size = 4;
        "col.active_border" = "rgba(7FB4CAff)";
        "col.inactive_border" = "rgba(3a3838aa)";
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
      ecosystem = {
        enforce_permissions = true;
      };
      permission = [
        "${lib.escapeRegex (lib.getExe pkgs.grim)}, screencopy, allow"
        "${
          lib.escapeRegex (lib.getExe inputs.hyprlock.packages.${pkgs.system}.hyprlock)
        }, screencopy, allow"
        "${
          lib.escapeRegex (lib.getExe inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland)
        }, screencopy, allow"
      ];
      plugin = {
        stack = {
          new_status = "master";
          mfact = 0.60;
          new_on_top = true;
          orientation = "left";
          inherit_fullscreen = false;
          smart_resizing = true;
          new_on_active = "before";
        };
      };
      workspace = [
        "1, monitor:DP-3, default:true"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        "6, monitor:DP-3"
        "7, monitor:DP-3"
        "8, monitor:DP-3"
        "9, monitor:DP-3"
        "11, monitor:HDMI-A-1, default:true"
        "12, monitor:HDMI-A-1"
        "13, monitor:HDMI-A-1"
        "14, monitor:HDMI-A-1"
        "15, monitor:HDMI-A-1"
        "16, monitor:HDMI-A-1"
        "17, monitor:HDMI-A-1"
        "18, monitor:HDMI-A-1"
        "19, monitor:HDMI-A-1"
      ];
      windowrule = [
        "float, class:pulsemixer, title:kitty"
        "center, class:pulsemixer, title:kitty"
        "size 50% 50%, class:pulsemixer, title:kitty"
        "float, class:^(mpv)$, title:^(fmpv)$"
        "tile, class:^(mpv)$, title:^(umpv)$"
        "workspace 1, class:^(LibreWolf)$, title:^(Navigator)$"
        "workspace 3, class:^(firefox)$, title:^(Mozilla Firefox)$"
        "workspace 3, class:^(st)$, title:^(anime_lf)$"
        "workspace 3, class:^(st)$, title:^(aniwiki)$"
        "workspace 4, class:^(Brave-browser)$"
        "workspace 4, class:^(brave-browser)$"
        "workspace 4, class:^(Lutris)$"
        "workspace 5, class:^(fate.exe)$"
        "float, class:^(fate.exe)$"
        "workspace 5, class:^(Steam)$, title:^(Steam)$"
        "float, class:^(Steam)$, title:^(Friends List)$"
        "workspace 5, class:^(Steam)$, title:^(Friends List)$"
        "workspace 6, class:^(transmission)$"
        "workspace 6, class:^(Transmission-gtk)$"
        "workspace 7, class:^(kdenlive)$"
        "workspace 8, class:^(Gimp)$"
        "workspace 9, class:^(KeePassXC)$"
        "monitor HDMI-A-1, title:Picture-in-Picture"
      ];
      bind = [
        "$mainMod SHIFT, Q, exec, loginctl terminate-user \"\""
        "$mainMod, RETURN, exec, uwsm app -- kitty tmux"
        "$mainMod, R, exec, $menu"
        "$mainMod, COMMA, exec, uwsm app -- wk --debug"
        "$mainMod, O, exec, uwsm app -- wk --press 'o'"
        "$mainMod, E, exec, uwsm app -- wk --press 'e'"
        "$mehMod, J, focusmonitor, l"
        "$mehMod, K, focusmonitor, r"
        "$mainMod, J, layoutmsg, cyclenext"
        "$mainMod, K, layoutmsg, cycleprev"
        "$mainMod, F, layoutmsg, focusmaster"
        "$mainMod SHIFT, J, layoutmsg, swapnext"
        "$mainMod SHIFT, K, layoutmsg, swapprev"
        "$mainMod, T, layoutmsg, orientationtop"
        "$mainMod, Q, killactive,"
        "$mainMod, SPACE, layoutmsg, swapwithmaster master"
        "$mainMod SHIFT, SPACE, togglefloating,"
        "$mainMod, V, fullscreen, 0"
        "$mainMod, I, fullscreen, 1"
        "$mainMod SHIFT, I, fullscreenstate, 0 2"
        "$mainMod SHIFT, Y, fullscreenstate, 0 0"
        "$mainMod, A, exec, hyprctl keyword general:gaps_in 0 && hyprctl keyword general:gaps_out 0"
        "$mainMod SHIFT, A, exec, hyprctl keyword general:gaps_in 10 && hyprctl keyword general:gaps_out 25, 20, 25, 20"
        "$mainMod, G, splitratio, -0.05"
        "$mainMod, SEMICOLON, splitratio, +0.05"
        "$mainMod, H, split-workspace, m-1"
        "$mainMod, L, split-workspace, m+1"
        "$mainMod, B, exec, killall -SIGUSR2 waybar"
        "$mainMod, S, exec, uwsm app -- wk --press 'os'"
        "$mainMod SHIFT, F, togglefloating,"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, pamixer --allow-boost -i 5"
        ", XF86AudioLowerVolume, exec, pamixer --allow-boost -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
      ];
      bindl = [
        ", XF86AudioNext, exec, mpc next"
        ", XF86AudioPrev, exec, mpc prev"
        ", XF86AudioPlay, exec, uwsm app -- media-toggle"
        ", XF86AudioRewind, exec, mpc seek -10"
        ", XF86AudioForward, exec, mpc seek +10"
        ", XF86AudioMedia, exec, uwsm app -- $terminal -e ncmpcpp"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };
    };
    extraConfig = ''
    '';
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 930;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/pictures/wp/1640963976704.png"];
      wallpaper = [",~/pictures/wp/1640963976704.png"];
    };
  };
}
