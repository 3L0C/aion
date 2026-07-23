{
  config,
  lib,
  pkgs,
  ...
}: let
  meh = "Shift+Control+Alt";

  # Programs
  kitty = lib.getExe pkgs.kitty;
  pamixer = lib.getExe pkgs.pamixer;
  brightnessctl = lib.getExe pkgs.brightnessctl;
  asusctl = lib.getExe' pkgs.asusctl "asusctl";
  rofi = lib.getExe config.programs.rofi.finalPackage;
  uwsm-app = lib.getExe' pkgs.uwsm "uwsm-app";
  touchpad-toggle = lib.getExe pkgs.custom.scripts.touchpad-toggle;

  launcher = "${uwsm-app} -- ${rofi} -show drun -run-command \"${uwsm-app} -- {cmd}\"";
  terminal = "${uwsm-app} -- ${kitty}";
  menu = "${uwsm-app} -- wk-river";

  # Only emit output-targeted lines for outputs this host actually has.
  monitorNames = map (m: m.name) config.monitors;
  onOutput = name: line: lib.optionalString (builtins.elem name monitorNames) line;

  colors = config.lib.stylix.colors.withHashtag;
in {
  xdg.configFile."ocdwm/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ### Settings ────────────────────────────────────────────────────────
      octl layout tiling stack spiral --all
      octl layout scrolling policy centered --all
      octl layout scrolling column-width --all 0.95
      octl output column width 0.95
      octl layout tiling nmaster 1
      octl layout tiling mfact 0.60
      octl gaps inner 10
      octl gaps outer 20
      octl border width 4
      octl border color focused '${colors.base0D}'
      octl border color unfocused '${colors.base04}'
      octl border color urgent '${colors.base08}'
      octl input pointer follow on
      octl input pointer warp on
      octl input keyboard repeat 50 250
      octl input cursor theme '${config.stylix.cursor.name}' ${toString config.stylix.cursor.size}

      ### Scrolling ───────────────────────────────────────────────────────
      octl bind window column consume to Super+c
      octl bind window column release to Super+x
      octl bind window column cycle to Super+d
      octl bind window column default to Super+0
      octl bind layout scrolling policy left to Super+f
      octl bind layout scrolling policy centered to Super+p
      octl bind layout scrolling policy visible to Super+b

      ### Overview ────────────────────────────────────────────────────────
      octl bind output overview to Super+g

      ### Window rules ────────────────────────────────────────────────────
      ${onOutput "DP-3" "octl rules add send --app-id=firefox DP-3"}
      octl rules add tag --app-id=firefox 3
      ${onOutput "DP-3" "octl rules add send --app-id=emacs DP-3"}
      octl rules add tag --app-id=emacs 2
      octl rules add tag --app-id=org.keepassxc.KeePassXC 9
      octl rules add tag --app-id=vesktop 4
      octl bind spawn '${terminal} tmux' to Super+Return
      octl bind spawn '${terminal}' to Super+Shift+Return
      octl bind spawn '${launcher}' to Super+r
      octl bind spawn '${menu}' to Super+comma
      octl bind spawn '${menu} --press "d u"' to Super+period
      octl bind spawn "${menu} --press 'o'" to Super+o
      octl bind spawn "${menu} --press 'e'" to Super+e
      octl bind session exit to Super+Shift+q
      octl bind output focus next to ${meh}+j
      octl bind output focus prev to ${meh}+k
      ${onOutput "HDMI-A-1" "octl bind output focus name HDMI-A-1 to ${meh}+m"}
      ${onOutput "DP-3" "octl bind output focus name DP-3 to ${meh}+n"}
      ${onOutput "DP-1" "octl bind output focus name DP-1 to ${meh}+e"}
      octl bind window send next --take to ${meh}+l
      octl bind window send prev --take to ${meh}+h
      octl bind window tag shift next --occupied to Super+Shift+l
      octl bind window tag shift prev --occupied to Super+Shift+h
      octl bind spawn 'octl window resize to 35% 35% && octl window move to 64% 62%' to Super+z

      ### Media keys (normal mode) ────────────────────────────────────────
      octl bind spawn '${pamixer} -i 5' to XF86AudioRaiseVolume
      octl bind spawn '${pamixer} -d 5' to XF86AudioLowerVolume
      octl bind spawn '${pamixer} --toggle-mute' to XF86AudioMute
      octl bind spawn 'media --toggle' to XF86AudioMedia
      octl bind spawn 'media --toggle' to XF86AudioPlay
      octl bind spawn 'media --prev' to XF86AudioPrev
      octl bind spawn 'media --next' to XF86AudioNext
      octl bind spawn '${brightnessctl} -d intel_backlight set +5%' to XF86MonBrightnessUp
      octl bind spawn '${brightnessctl} -d intel_backlight set 5%-' to XF86MonBrightnessDown
      octl bind spawn '${asusctl} leds next' to XF86KbdBrightnessUp
      octl bind spawn '${asusctl} leds prev' to XF86KbdBrightnessDown
      octl bind spawn '${touchpad-toggle}' to XF86TouchpadToggle
      octl bind spawn --mode=locked '${pamixer} -i 5' to XF86AudioRaiseVolume
      octl bind spawn --mode=locked '${pamixer} -d 5' to XF86AudioLowerVolume
      octl bind spawn --mode=locked '${pamixer} --toggle-mute' to XF86AudioMute
      octl bind spawn --mode=locked 'media --toggle' to XF86AudioPlay
      octl bind spawn --mode=locked 'media --prev' to XF86AudioPrev
      octl bind spawn --mode=locked 'media --next' to XF86AudioNext
      octl bind spawn --mode=locked '${brightnessctl} -d intel_backlight set +5%' to XF86MonBrightnessUp
      octl bind spawn --mode=locked '${brightnessctl} -d intel_backlight set 5%-' to XF86MonBrightnessDown
      octl bind spawn --mode=locked '${touchpad-toggle}' to XF86TouchpadToggle
    '';
  };

  # Scripts referenced by bindings
  home.packages = [pkgs.custom.scripts.touchpad-toggle];
}
