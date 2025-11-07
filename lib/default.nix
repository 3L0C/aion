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
    mkRiverBindsScript = pkgs: name: {
      mode ? "normal",
      bindings,
    }: let
      riverctl = "${lib.getExe' pkgs.river-classic "riverctl"}";
      bindingLines = map (binding: "${riverctl} map ${mode} ${binding}") bindings;
    in
      pkgs.writeShellScript name (lib.concatStringsSep "\n" bindingLines);
  };
}
