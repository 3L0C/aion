{
  config,
  lib,
  pkgs,
  ...
}: let
  mod = "Super";
  meh = "Shift+Control+Alt";
  modShift = "${mod}+Shift";
  brightnessctl = "${lib.getExe pkgs.brightnessctl}";
  kitty = "${lib.getExe pkgs.kitty}";
  loginctl = "${lib.getExe' pkgs.systemd "loginctl"}";
  pamixer = "${lib.getExe pkgs.pamixer}";
  playerctl = "${lib.getExe pkgs.playerctl}";
  river-shifttags = "${lib.getExe pkgs.custom.river-shifttags}";
  rofi = "${lib.getExe config.programs.rofi.finalPackage}";
  launcher = "uwsm-app -- ${rofi} -show drun -run-command '\\''uwsm-app -- {cmd}'\\''";
  menu = "uwsm-app -- ${lib.getExe pkgs.wk-patched}";
  terminal = "uwsm-app -- ${kitty}";
  mediaKeyBinds = {
    "None XF86AudioRaiseVolume" = "spawn '${pamixer} -i 5'";
    "None XF86AudioLowerVolume" = "spawn '${pamixer} -d 5'";
    "None XF86AudioMute" = "spawn '${pamixer} --toggle-mute'";
    "None XF86AudioMedia" = "spawn '${playerctl} play-pause'";
    "None XF86AudioPlay" = "spawn '${playerctl} play-pause'";
    "None XF86AudioPrev" = "spawn '${playerctl} previous'";
    "None XF86AudioNext" = "spawn '${playerctl} next'";
    "None XF86MonBrightnessUp" = "spawn '${brightnessctl} set +5%'";
    "None XF86MonBrightnessDown" = "spawn '${brightnessctl} set 5%-'";
  };
in {
  wayland.windowManager.river.settings = {
    declare-mode = ["normal" "locked"];
    map.normal =
      {
        "${mod} Return" = "spawn '${terminal} tmux'";
        "${modShift} Return" = "spawn '${terminal}'";
        "${mod} R" = "spawn '${launcher}'";
        "${mod} Comma" = "spawn '${menu}'";
        "${mod} O" = "spawn '${menu} --press '\\''o'\\'''";
        "${mod} E" = "spawn '${menu} --press '\\''e'\\'''";
        "${mod} S" = "spawn '${menu} --press '\\''os'\\'''";
        "${mod} Q" = "close";
        "${modShift} Q" = "spawn '${loginctl} terminate-user \"\"'";
        "${meh} J" = "focus-output next";
        "${meh} K" = "focus-output previous";
        "${meh} Space" = "focus-output next";
        "${mod} J" = "focus-view next";
        "${mod} K" = "focus-view previous";
        "${modShift} L" = "send-to-output next";
        "${modShift} H" = "send-to-output previous";
        "${mod} L" = "spawn '${river-shifttags} --occupied'";
        "${mod} H" = "spawn '${river-shifttags} --shift -1 --occupied'";
        "${modShift} J" = "swap next";
        "${modShift} K" = "swap previous";
        "${modShift} Space" = "toggle-float";
        "${mod} V" = "toggle-fullscreen";
        "${mod} Space" = "zoom";
      }
      // mediaKeyBinds;

    map.locked = mediaKeyBinds;
    map-pointer.normal = {
      "${mod} BTN_LEFT" = "move-view";
      "${mod} BTN_RIGHT" = "resize-view";
    };
  };
}
