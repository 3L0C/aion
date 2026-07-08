{lib, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = false;
      splash = false;
    };
  };
  systemd.user.services.hyprpaper = lib.custom.scopeServiceToWaylandSessions {
    "hyprland.desktop" = {};
  };
}
