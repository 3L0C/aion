{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$mehMod" = "SHIFT ALT CTRL";

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
      "$mainMod, H, workspace, m-1"
      "$mainMod, L, workspace, m+1"
      "$mainMod, B, exec, killall -SIGUSR2 waybar"
      "$mainMod, S, exec, uwsm app -- wk --press 'os'"
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
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
  };
}
