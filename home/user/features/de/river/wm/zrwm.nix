{
  config,
  lib,
  pkgs,
  ...
}: let
  zrwm = lib.getExe' pkgs.custom.zrwm "zrwm";
  zrwm-msg = lib.getExe' pkgs.custom.zrwm "zrwm-msg";
  shell = pkgs.runtimeShell;
  mod = config.userSpec.modifierKeys.river;
  modShift = "${mod},shift";
  modCtrl = "${mod},ctrl";
  uwsm = lib.getExe pkgs.uwsm;
  uwsm-app = "${uwsm} app";
  rofi = lib.getExe config.programs.rofi.finalPackage;
  kitty = lib.getExe pkgs.kitty;
  pamixer = lib.getExe pkgs.pamixer;
  brightnessctl = lib.getExe pkgs.brightnessctl;
  touchpad-toggle = lib.getExe pkgs.custom.scripts.touchpad-toggle;

  launcher = "${uwsm-app} -- ${rofi} -show drun -run-command \"${uwsm-app} -- {cmd}\"";
  menu = "${uwsm-app} -- wk-river";
  terminal = "${uwsm-app} -- ${kitty}";
in {
  home.packages = [pkgs.custom.zrwm];
  xdg.configFile."zrwm/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      ${zrwm-msg} clear-binds
      ${zrwm-msg} clear-rules
      TAGKEYS() {
        ${zrwm-msg} bind ${mod} $(($1 + 1)) view $((1 << $1))
        ${zrwm-msg} bind ${modCtrl} $(($1 + 1)) toggleview $((1 << $1))
        ${zrwm-msg} bind ${modShift} $(($1 + 1)) tag $((1 << $1))
        ${zrwm-msg} bind ${mod},shift,ctrl $(($1 + 1)) toggletag $((1 << $1))
      }
      for i in 0 1 2 3 4 5 6 7 8; do TAGKEYS "$i"; done
      ${zrwm-msg} bind ${mod} Return spawn ${shell} -c '${terminal} tmux'
      ${zrwm-msg} bind ${modShift} Return spawn ${shell} -c '${terminal}'
      ${zrwm-msg} bind ${mod} r spawn ${shell} -c '${launcher}'
      ${zrwm-msg} bind ${mod} comma spawn ${shell} -c '${menu}'
      ${zrwm-msg} bind ${mod} period spawn ${shell} -c '${menu} --press "d u"'
      ${zrwm-msg} bind ${mod} o spawn ${shell} -c "${menu} --press 'o'"
      ${zrwm-msg} bind ${mod} e spawn ${shell} -c "${menu} --press 'e'"
      ${zrwm-msg} bind ${mod} q killwindow
      ${zrwm-msg} bind ${modShift} q spawn ${shell} -c '${uwsm} stop'
      ${zrwm-msg} bind ${mod} j focusstack 1
      ${zrwm-msg} bind ${mod} k focusstack -1
      ${zrwm-msg} bind ${modShift} j pushdown
      ${zrwm-msg} bind ${modShift} k pushup
      ${zrwm-msg} bind ${modShift} space togglefloating
      ${zrwm-msg} bind ${mod} v togglefullscreen
      ${zrwm-msg} bind ${mod} s togglesticky
      ${zrwm-msg} bind ${mod} h setmfact -0.05
      ${zrwm-msg} bind ${mod} l setmfact 0.05
      ${zrwm-msg} bind ${mod} y setlayout split_tile
      ${zrwm-msg} bind ${mod} i setlayout deck
      ${zrwm-msg} bind ${mod} t setlayout split_tile
      ${zrwm-msg} bind ${modShift} s setlayout float
      ${zrwm-msg} bind ${mod} BackSpace reload
      ${zrwm-msg} bind none XF86AudioRaiseVolume spawn ${shell} -c '${pamixer} -i 5'
      ${zrwm-msg} bind none XF86AudioLowerVolume spawn ${shell} -c '${pamixer} -d 5'
      ${zrwm-msg} bind none XF86AudioMute spawn ${shell} -c '${pamixer} --toggle-mute'
      ${zrwm-msg} bind none XF86AudioMedia spawn ${shell} -c 'media --toggle'
      ${zrwm-msg} bind none XF86AudioPlay spawn ${shell} -c 'media --toggle'
      ${zrwm-msg} bind none XF86AudioPrev spawn ${shell} -c 'media --prev'
      ${zrwm-msg} bind none XF86AudioNext spawn ${shell} -c 'media --next'
      ${zrwm-msg} bind none XF86MonBrightnessUp spawn ${shell} -c '${brightnessctl} -d intel_backlight set +5%'
      ${zrwm-msg} bind none XF86MonBrightnessDown spawn ${shell} -c '${brightnessctl} -d intel_backlight set 5%-'
      ${zrwm-msg} bind none XF86TouchpadToggle spawn ${shell} -c '${touchpad-toggle}'
    '';
  };
  systemd.user.services.zrwm = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "zrwm window manager for River 0.4.x";
        Documentation = "https://git.sr.ht/~zuki/zrwm";
      };

      Service = {
        Type = "simple";
        ExecStart = zrwm;
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
  };
}
