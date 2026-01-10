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
      PartOf = lib.mkForce ["wayland-session@start\\x2dhyprland.target"];
      After = lib.mkForce ["wayland-wm@start\\x2dhyprland.service"];
    };
    Install = {
      WantedBy = lib.mkForce ["wayland-session@start\\x2dhyprland.target"];
    };
  };
}
