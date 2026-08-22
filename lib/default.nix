{lib, ...}: {
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
  };
}
