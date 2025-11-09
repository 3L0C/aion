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
  river-shifttags = "${lib.getExe pkgs.custom.river-shifttags}";
  river-swap = "${lib.getExe pkgs.river-swap}";
  rofi = "${lib.getExe config.programs.rofi.finalPackage}";
  launcher = "uwsm-app -- ${rofi} -show drun -run-command '\\''uwsm-app -- {cmd}'\\''";
  menu = "uwsm-app -- ${lib.getExe pkgs.wk-patched}";
  terminal = "uwsm-app -- ${kitty}";
  normalBindings = lib.custom.mkRiverBindsScript pkgs "river-normal-bindings" {
    bindings = [
      "${mod} Return spawn '${terminal} tmux'"
      "${modShift} Return spawn '${terminal}'"
      "${mod} R spawn '${launcher}'"
      "${mod} Comma spawn '${menu}'"
      ''${mod} O spawn "${menu} --press 'o'"''
      ''${mod} E spawn "${menu} --press 'e'"''
      ''${mod} S spawn "${menu} --press 'os'"''
      "${mod} Q close"
      ''${modShift} Q spawn '${loginctl} terminate-user ""' ''
      "${meh} J focus-output next"
      "${meh} K focus-output previous"
      "${meh} Space spawn '${river-swap}'"
      "${mod} J focus-view next"
      "${mod} K focus-view previous"
      "${meh} L send-to-output next"
      "${meh} H send-to-output previous"
      "${mod} L spawn '${river-shifttags} --occupied'"
      "${mod} H spawn '${river-shifttags} --shifts -1 --occupied'"
      "${mod} Tab spawn '${river-shifttags}'"
      "${modShift} ISO_Left_Tab spawn '${river-shifttags} --shifts -1'"
      "${modShift} L spawn '${river-shifttags} --send-view'"
      "${modShift} H spawn '${river-shifttags} --send-view --shifts -1'"
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
