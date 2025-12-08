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
  riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
  riverdo = "${lib.getExe pkgs.riverdo}";
  rofi = "${lib.getExe config.programs.rofi.finalPackage}";
  uwsm-app = "${lib.getExe' pkgs.uwsm "uwsm-app"}";
  launcher = "${uwsm-app} -- ${rofi} -show drun -run-command \"${uwsm-app} -- {cmd}\"";
  menu = "${uwsm-app} -- wk-river";
  old-menu = "${uwsm-app} -- wk";
  terminal = "${uwsm-app} -- ${kitty}";
  normalBindings = lib.custom.mkRiverBindsScript pkgs "river-normal-bindings" {
    bindings = [
      "${mod} Z spawn '${riverdo} move-to top-left 0 resize-to 35%x35% move-to bottom-right 20 stick --tags occupied'"
      "${mod} Return spawn '${terminal} tmux'"
      "${modShift} Return spawn '${terminal}'"
      "${mod} R spawn '${launcher}'"
      "${mod} Comma spawn '${menu}'"
      "${mod} Period spawn '${old-menu}'"
      ''${mod} O spawn "${menu} --press 'o'"''
      ''${mod} E spawn "${menu} --press 'e'"''
      "${mod} Q close"
      ''${modShift} Q spawn '${loginctl} terminate-user ""' ''
      "${meh} J focus-output next"
      "${meh} K focus-output previous"
      "${meh} Space spawn '${riverdo} swap-outputs --focused-tag'"
      "${mod} J focus-view next"
      "${mod} K focus-view previous"
      "${meh} L spawn '${riverdo} output next'"
      "${meh} H spawn '${riverdo} output previous'"
      "${mod} L spawn '${riverdo} shift-tag next --occupied'"
      "${mod} H spawn '${riverdo} shift-tag previous --occupied'"
      "${mod} Tab spawn '${riverdo} shift-tag +1'"
      "${modShift} Tab spawn '${riverdo} shift-tag -1'"
      "${modShift} L spawn '${riverdo} shift-view next --occupied'"
      "${modShift} H spawn '${riverdo} shift-view previous --occupied'"
      "${mod} S spawn '${riverdo} stick --tags occupied'"
      "${modShift} S spawn '${riverdo} unstick'"
      "${modShift} J swap next"
      "${modShift} K swap previous"
      "${modShift} Space toggle-float"
      "${mod} V toggle-fullscreen"
      "${mod} Space zoom"
      "None XF86AudioRaiseVolume spawn '${pamixer} -i 5'"
      "None XF86AudioLowerVolume spawn '${pamixer} -d 5'"
      "None XF86AudioMute spawn '${pamixer} --toggle-mute'"
      "None XF86AudioMedia spawn '${playerctl} play-pause'"
      "None XF86AudioPlay spawn '${playerctl} play-pause'"
      "None XF86AudioPrev spawn '${playerctl} previous'"
      "None XF86AudioNext spawn '${playerctl} next'"
      "None XF86MonBrightnessUp spawn '${brightnessctl} set +5%'"
      "None XF86MonBrightnessDown spawn '${brightnessctl} set 5%-'"
    ];
  };
  lockedBindings = lib.custom.mkRiverBindsScript pkgs "river-locked-bindings" {
    mode = "locked";
    bindings = [
      "None XF86AudioRaiseVolume spawn '${pamixer} -i 5'"
      "None XF86AudioLowerVolume spawn '${pamixer} -d 5'"
      "None XF86AudioMute spawn '${pamixer} --toggle-mute'"
      "None XF86AudioMedia spawn '${playerctl} play-pause'"
      "None XF86AudioPlay spawn '${playerctl} play-pause'"
      "None XF86AudioPrev spawn '${playerctl} previous'"
      "None XF86AudioNext spawn '${playerctl} next'"
      "None XF86MonBrightnessUp spawn '${brightnessctl} set +5%'"
      "None XF86MonBrightnessDown spawn '${brightnessctl} set 5%-'"
    ];
  };
  keybindingsScript = pkgs.writeShellScript "river-keybindings" ''
    ${riverctl} declare-mode normal
    ${riverctl} declare-mode locked
    ${normalBindings}
    ${lockedBindings}
    ${riverctl} map-pointer normal ${mod} BTN_LEFT move-view
    ${riverctl} map-pointer normal ${mod} BTN_RIGHT resize-view
  '';
in {
  systemd.user.services.river-keybindings = lib.custom.mkWaylandService "river" {
    Unit = {
      Description = "River compositor keybindings";
      Documentation = "man:riverctl(1)";
    };

    Service = {
      Type = "oneshot";
      ExecStart = keybindingsScript;
      RemainAfterExit = true;
    };
  };
}
