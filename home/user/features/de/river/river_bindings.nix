{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  mod = "Super";
  meh = "Shift+Control+Alt";
  modShift = "${mod}+Shift";
  kitty = "${lib.getExe pkgs.kitty}";
  terminal = "uwsm-app -- ${kitty}";
  _terminal = "${kitty}";
  rofi = "${lib.getExe config.programs.rofi.finalPackage}";
  launcher = "uwsm-app -- ${rofi} -show drun";
  menu = "uwsm-app -- ${lib.getExe inputs.wk.packages.${pkgs.system}.wk}";
in {
  wayland.windowManager.river.settings = {
    declare-mode = ["normal" "locked"];
    map.normal = {
      "${mod} Return" = "spawn '${terminal}'";
      "${modShift} Return" = "spawn '${_terminal}'";
      "${mod} R" = "spawn '${launcher}'";
      "${mod} Comma" = "spawn '${menu}'";
      "${mod} Q" = "close";
      "${modShift} Q" = "exit";
      "${meh} J" = "focus-output DP-3";
      "${meh} K" = "focus-output HDMI-A-1";
      "${mod} J" = "focus-view next";
      "${mod} K" = "focus-view previous";
      "${modShift} J" = "swap next";
      "${modShift} K" = "swap previous";
      "${modShift} Space" = "toggle-float";
      "${mod} V" = "toggle-fullscreen";
      "${mod} Space" = "zoom";
    };
    map-pointer.normal = {
      "${mod} BTN_LEFT" = "move-view";
      "${mod} BTN_RIGHT" = "resize-view";
    };
  };
}
