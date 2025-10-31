{config, ...}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "uwsm app -- dunst"
      "${hyprctl} setcursor phinger-cursors-dark 24"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "uwsm app -- dbus-update-activation-environment --systemd --all"
      "systemctl --user import-environment QT_QPA_PLATFORMTHEME"
      "uwsm app -- waybar"
      "uwsm app -- tmux new-session -s x-server -d &"
      "uwsm app -- setsid -f wpctl-settings"
      "uwsm app -- mpd &"
    ];
  };
}
