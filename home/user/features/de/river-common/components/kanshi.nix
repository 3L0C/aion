{
  config,
  lib,
  ...
}: let
  monitorToKanshiOutput = monitor:
    lib.filterAttrs (_: v: v != null) {
      criteria = monitor.name;
      status =
        if monitor.enabled
        then "enable"
        else "disable";
      mode = "${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate}Hz";
      position = "${toString monitor.x},${toString monitor.y}";
      inherit (monitor) transform;
      scale =
        if monitor.scale != "auto"
        then builtins.fromJSON monitor.scale * 1.0 # Ensure float
        else null;
    };
  applyOverride = overrides: monitor:
    monitor // (overrides.${monitor.name} or {});
  profileExec = ["systemctl --user restart swaybg.service"];
  allMonitorsProfile = {
    profile = {
      name = "all";
      outputs = map monitorToKanshiOutput config.monitors;
      exec = profileExec;
    };
  };
  mkLayoutProfile = layoutName: overrides: {
    profile = {
      name = layoutName;
      outputs = map (m: monitorToKanshiOutput (applyOverride overrides m)) config.monitors;
      exec = profileExec;
    };
  };
  layoutProfiles = lib.mapAttrsToList mkLayoutProfile config.monitorLayouts;

  # Create individual profile for each monitor (fallback)
  mkSingleMonitorProfile = monitor: {
    profile = {
      inherit (monitor) name;
      outputs = [(monitorToKanshiOutput monitor)];
      exec = profileExec;
    };
  };
  singleMonitorProfiles = map mkSingleMonitorProfile config.monitors;
in {
  services.kanshi = {
    enable = true;
    systemdTarget = "";

    settings =
      [allMonitorsProfile]
      ++ layoutProfiles
      ++ singleMonitorProfiles;
  };
  systemd.user.services.kanshi = lib.custom.scopeServiceToWaylandSessions {
    riverclassic = {};
    river = {};
  };
}
