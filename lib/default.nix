{lib, ...}: {
  custom = {
    relativeToRoot = lib.path.append ../.;
    mkWaylandService = session: serviceConfig:
      lib.recursiveUpdate serviceConfig {
        Unit = {
          PartOf = ["wayland-session@${session}.target"];
          After = ["wayland-session@${session}.target"];
        };
        Install = {
          WantedBy = ["wayland-session@${session}.target"];
        };
      };
    scopeServiceToWaylandSession = session: serviceConfig:
      lib.recursiveUpdate serviceConfig {
        Unit = {
          PartOf = ["wayland-session@${session}.target"];
          After = ["wayland-session@${session}.target"];
        };
        Install = {
          WantedBy = lib.mkForce ["wayland-session@${session}.target"];
        };
      };
  };
}
