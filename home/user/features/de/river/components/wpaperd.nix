{lib, ...}: {
  services.wpaperd = {
    enable = true;
  };
  systemd.user.services.wpaperd = lib.custom.scopeServiceToWaylandSessions {
    river = {};
    riverdev = {};
  };
}
