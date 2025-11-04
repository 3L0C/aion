{
  config,
  lib,
  ...
}: let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
in {
  programs.swaylock = {
    enable = true;

    settings = {
      # Behavior
      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = false;
      indicator-radius = 100;
      indicator-thickness = 10;
      image = lib.mkDefault "~/.config/hypr/1450741833367.jpg"; # Reuse Hyprland wallpaper
      scaling = "fill";
      daemonize = false;
    };
  };
  systemd.user.services.swaylock = {
    Unit = {
      Description = "Screen locker for River";
      PartOf = ["wayland-session@River.target"];
    };
    Service = {
      ExecStart = "${swaylock} --daemonize";
      Restart = "on-failure";
    };
  };
}
