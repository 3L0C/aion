{lib, ...}: {
  services.wpaperd = {
    enable = true;
  };
  systemd.user.services.wpaperd = lib.custom.scopeServiceToWaylandSessions {
    riverclassic = {};
    river = {};
  };
}
