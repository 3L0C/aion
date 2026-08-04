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
  xdg.configFile."oxbow/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      ### Settings ────────────────────────────────────────────────────────
      oxctl gaps inner 10
      oxctl gaps outer 20
      oxctl border width 4
      oxctl border color focused '${colors.base0D}'
      oxctl border color unfocused '${colors.base04}'
      oxctl border color urgent '${colors.base08}'
      oxctl input pointer follow on
      oxctl input pointer warp on
      oxctl input keyboard repeat 50 250
      oxctl input cursor theme '${config.stylix.cursor.name}' ${toString config.stylix.cursor.size}

      ### Tiling ──────────────────────────────────────────────────────────
      oxctl output column width 0.95
      oxctl layout tiling nmaster 1
      oxctl layout tiling mfact 0.60

      ### Scrolling ───────────────────────────────────────────────────────
      oxctl layout scrolling policy visible --all
      oxctl layout scrolling default-width --all 0.95
      ${onOutput "DP-3" "oxctl layout scrolling --output DP-3"}
      oxctl bind window column default to Super+a
      oxctl bind window column consume to Super+c
      oxctl bind window column release to Super+x
      oxctl bind window column cycle to Super+d
      oxctl bind window column default to Super+0
      oxctl bind layout scrolling policy left to Super+f
      oxctl bind layout scrolling policy centered to Super+p
      oxctl bind layout scrolling policy visible to Super+b

      ### Overview ────────────────────────────────────────────────────────
      oxctl bind output overview cycle next --until-release=Super to Super+n
      oxctl bind output overview cycle prev --until-release=Super to Super+Shift+n

      ### Swaps ───────────────────────────────────────────────────────────
      oxctl bind output swap tags --ring HDMI-A-1,DP-3,DP-1 --rev to ${meh}+space
      oxctl bind output swap tags --ring HDMI-A-1,DP-3,DP-1 to ${meh}+parenright
      oxctl bind output swap tags --ring HDMI-A-1,DP-3,DP-1 to ${meh}+j
      oxctl bind output swap tags --ring HDMI-A-1,DP-3,DP-1 --rev to ${meh}+k

      ### Window rules ────────────────────────────────────────────────────
      oxctl window rules add --tags 3 --output=DP-3 --app-id=firefox
      oxctl window rules add --tags 2 --output=DP-3 --app-id=emacs
      oxctl window rules add --tags 9 --app-id=org.keepassxc.KeePassXC
      oxctl window rules add --tags 4 --app-id=vesktop
      oxctl window rules add --tags 4 --output=DP-3 --app-id=steam
      oxctl bind spawn '${terminal} tmux' to Super+Return
      oxctl bind spawn '${terminal}' to Super+Shift+Return
      oxctl bind spawn '${launcher}' to Super+r
      oxctl bind spawn '${menu}' to Super+comma
      oxctl bind spawn '${menu} --press "d u"' to Super+period
      oxctl bind spawn "${menu} --press 'o'" to Super+o
      oxctl bind spawn "${menu} --press 'e'" to Super+e
      oxctl bind session exit to Super+Shift+q
      ${onOutput "HDMI-A-1" "oxctl bind output focus name HDMI-A-1 to ${meh}+m"}
      ${onOutput "DP-3" "oxctl bind output focus name DP-3 to ${meh}+n"}
      ${onOutput "DP-1" "oxctl bind output focus name DP-1 to ${meh}+e"}
      oxctl bind window send next --take to ${meh}+l
      oxctl bind window send prev --take to ${meh}+h
      oxctl bind window tag shift next --occupied to Super+Shift+l
      oxctl bind window tag shift prev --occupied to Super+Shift+h
      oxctl bind spawn 'oxctl window resize to 35% 35% && oxctl window move to 64% 62%' to Super+z

      ### Media keys (normal mode) ────────────────────────────────────────
      oxctl bind spawn '${pamixer} -i 5' to XF86AudioRaiseVolume
      oxctl bind spawn '${pamixer} -d 5' to XF86AudioLowerVolume
      oxctl bind spawn '${pamixer} --toggle-mute' to XF86AudioMute
      oxctl bind spawn 'media --toggle' to XF86AudioMedia
      oxctl bind spawn 'media --toggle' to XF86AudioPlay
      oxctl bind spawn 'media --prev' to XF86AudioPrev
      oxctl bind spawn 'media --next' to XF86AudioNext
      oxctl bind spawn '${brightnessctl} -d intel_backlight set +5%' to XF86MonBrightnessUp
      oxctl bind spawn '${brightnessctl} -d intel_backlight set 5%-' to XF86MonBrightnessDown
      oxctl bind spawn '${asusctl} leds next' to XF86KbdBrightnessUp
      oxctl bind spawn '${asusctl} leds prev' to XF86KbdBrightnessDown
      oxctl bind spawn '${touchpad-toggle}' to XF86TouchpadToggle

      ### Locked mode ─────────────────────────────────────────────────────
      # NOTE: whether oxbow auto-enters "locked" on session lock is
      # unverified — see gap list. Declared + bound so it works if/when it does.
      oxctl bind spawn --mode=locked '${pamixer} -i 5' to XF86AudioRaiseVolume
      oxctl bind spawn --mode=locked '${pamixer} -d 5' to XF86AudioLowerVolume
      oxctl bind spawn --mode=locked '${pamixer} --toggle-mute' to XF86AudioMute
      oxctl bind spawn --mode=locked 'media --toggle' to XF86AudioPlay
      oxctl bind spawn --mode=locked 'media --prev' to XF86AudioPrev
      oxctl bind spawn --mode=locked 'media --next' to XF86AudioNext
      oxctl bind spawn --mode=locked '${brightnessctl} -d intel_backlight set +5%' to XF86MonBrightnessUp
      oxctl bind spawn --mode=locked '${brightnessctl} -d intel_backlight set 5%-' to XF86MonBrightnessDown
      oxctl bind spawn --mode=locked '${touchpad-toggle}' to XF86TouchpadToggle
    '';
  };

  # Scripts referenced by bindings
  home.packages = [pkgs.custom.scripts.touchpad-toggle];
}
