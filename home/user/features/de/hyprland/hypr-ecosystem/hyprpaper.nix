{lib, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = false;
      splash = false;
    };
  };
  systemd.user.services.hyprpaper = {
    Unit = {
      PartOf = ["wayland-session@Hyprland.target"];
      After = ["wayland-session@Hyprland.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@Hyprland.target"];
    };
  };
}
