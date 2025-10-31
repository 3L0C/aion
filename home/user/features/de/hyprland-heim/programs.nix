{config, ...}: let
  hyprctl = "${config.wayland.windowManager.hyprland.finalPackage}/bin/hyprctl";
in {
  wayland.windowManager.hyprland.settings = {
    "$terminal" = "uwsm app -- kitty";
    "$fileManager" = "uwsm app -- lf";
    "$menu" = "uwsm app -- rofi -show drun -monitor \"$(${hyprctl} monitors -j | jq -r '.[] | select(.focused) | .name')\"";
    "$browser" = "uwsm app -- $BROWSER";
  };
}
