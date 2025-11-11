{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
  rofi = "${config.programs.rofi.package}/bin/rofi";
  kitty = "${pkgs.kitty}/bin/kitty";
  jq = "${pkgs.jq}/bin/jq";
  terminal = "uwsm-app -- ${kitty}";
  ncmpcpp = "${pkgs.ncmpcpp}/bin/ncmpcpp";

  mod = "SUPER";
  modShift = "SUPER_SHIFT";
  modMeh = "SHIFT_ALT_CTRL";
  menu = "uwsm-app -- ${rofi} -show drun -monitor \"$(${hyprctl} monitors -j | ${jq} -r '.[] | select(.focused) | .name')\"";

  workspaces = {
    "1" = "1";
    "2" = "2";
    "3" = "3";
    "4" = "4";
    "5" = "5";
    "6" = "6";
    "7" = "7";
    "8" = "8";
    "9" = "9";
    "10" = "0";
  };
in {
  wayland.windowManager.hyprland.settings = {
    bind =
      [
        "${modShift}, Q, exec, loginctl terminate-user \"\""
        "${mod}, RETURN, exec, uwsm-app -- ${kitty} tmux"
        "${mod}, R, exec, ${menu}"
        "${mod}, COMMA, exec, uwsm-app -- wk --wks-file ~/.config/wk/hyprland_key_chords.wks --debug"
        "${mod}, O, exec, uwsm-app -- wk --wks-file ~/.config/wk/hyprland_key_chords.wks --press 'o'"
        "${mod}, E, exec, uwsm-app -- wk --wks-file ~/.config/wk/hyprland_key_chords.wks --press 'e'"
        "${modMeh}, J, focusmonitor, l"
        "${modMeh}, K, focusmonitor, r"
        "${mod}, J, layoutmsg, cyclenext"
        "${mod}, K, layoutmsg, cycleprev"
        "${mod}, F, layoutmsg, focusmaster"
        "${modShift}, J, layoutmsg, swapnext"
        "${modShift}, K, layoutmsg, swapprev"
        "${mod}, T, layoutmsg, orientationtop"
        "${mod}, Q, killactive,"
        "${mod}, SPACE, layoutmsg, swapwithmaster master"
        "${mod} SHIFT, SPACE, togglefloating,"
        "${mod}, V, fullscreen, 0"
        "${mod}, I, fullscreen, 1"
        "${modShift}, I, fullscreenstate, 0 2"
        "${modShift}, Y, fullscreenstate, 0 0"
        "${mod}, A, exec, hyprctl keyword general:gaps_in 0 && hyprctl keyword general:gaps_out 0"
        "${modShift}, A, exec, hyprctl keyword general:gaps_in 10 && hyprctl keyword general:gaps_out 25, 20, 25, 20"
        "${mod}, G, splitratio, -0.05"
        "${mod}, SEMICOLON, splitratio, +0.05"
        "${mod}, H, workspace, m-1"
        "${mod}, L, workspace, m+1"
        "${mod}, B, exec, killall -SIGUSR2 waybar"
        "${mod}, S, exec, uwsm-app -- wk --wks-file ~/.config/wk/hyprland_key_chords.wks --press 'os'"
        "${modShift}, F, togglefloating,"
      ]
      ++ (lib.mapAttrsToList (n: key: "${mod}, ${key}, workspace, ${n}") workspaces)
      ++ (lib.mapAttrsToList (n: key: "${modShift}, ${key}, movetoworkspacesilent, ${n}") workspaces);
    bindel = [
      ", XF86AudioRaiseVolume, exec, pamixer --allow-boost -i 5"
      ", XF86AudioLowerVolume, exec, pamixer --allow-boost -d 5"
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
    ];
    bindl = [
      ", XF86AudioNext, exec, mpc next"
      ", XF86AudioPrev, exec, mpc prev"
      ", XF86AudioPlay, exec, uwsm-app -- media-toggle"
      ", XF86AudioRewind, exec, mpc seek -10"
      ", XF86AudioForward, exec, mpc seek +10"
      ", XF86AudioMedia, exec, uwsm-app -- ${terminal} -e ${ncmpcpp}"
    ];
    bindm = [
      "${mod}, mouse:272, movewindow"
      "${mod}, mouse:273, resizewindow"
    ];
  };
}
