{lib, ...}: let
  pow2 = n:
    if n == 0
    then 1
    else 2 * pow2 (n - 1);
in {
  custom = {
    relativeToRoot = lib.path.append ../.;
    mkWaylandService = sessions: let
      sessionNames = builtins.attrNames sessions;
      targets = map (s: "wayland-session@${s}.target") sessionNames;
      wmServices = map (s: "wayland-wm@${s}.service") sessionNames;
      mergedConfig = lib.foldl' lib.recursiveUpdate {} (builtins.attrValues sessions);
    in
      lib.recursiveUpdate mergedConfig {
        Unit = {
          PartOf = lib.mkForce targets;
          After = lib.mkForce wmServices;
        };
        Install = {
          WantedBy = lib.mkForce targets;
        };
      };
    scopeServiceToWaylandSessions = sessions: let
      sessionNames = builtins.attrNames sessions;
      targets = map (s: "wayland-session@${s}.target") sessionNames;
      wmServices = map (s: "wayland-wm@${s}.service") sessionNames;
      mergedConfig = lib.foldl' lib.recursiveUpdate {} (builtins.attrValues sessions);
    in
      lib.recursiveUpdate mergedConfig {
        Unit = {
          PartOf = lib.mkForce targets;
          After = lib.mkForce wmServices;
        };
        Install = {
          WantedBy = lib.mkForce targets;
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
    powerOf2 = pow2;
    bitShiftLeft = val: n: val * pow2 n;
    bitShiftRight = val: n: val / pow2 n;
  };
}
