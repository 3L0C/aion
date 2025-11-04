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
      PartOf = ["hyprland-session.target"];
      After = ["hyprland-session.target"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@Hyprland.desktop.target"];
    };
  };
}
