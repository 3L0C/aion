# oxbow window manager services. The session target starts the
# stock input build. oxbow-dev runs the local build with debug
# logging; manual start only, and the two conflict.
{config, ...}: let
  lib' = config.flake.lib;
in {
  flake.modules.homeManager.oxbow = {pkgs, ...}: let
    oxbowDevBin = "/home/user/Projects/oxbow-dev/_build/install/default/bin";

    mkOxbowService = {
      description,
      execStart,
      conflicts,
    }:
      lib'.mkWaylandService {
        river = {
          Unit = {
            Description = description;
            Conflicts = [conflicts];
          };

          Service = {
            Type = "simple";
            ExecStart = execStart;
            Restart = "on-failure";
            RestartSec = "3s";
          };
        };
      };
  in {
    systemd.user.services = {
      oxbow = mkOxbowService {
        description = "oxbow window manager for River 0.4.x";
        execStart = "${pkgs.oxbow}/bin/oxbow --log-level info";
        conflicts = "oxbow-dev.service";
      };

      # Keep the session scoping (PartOf/After) but drop [Install]:
      # the session target must not want the dev unit. Manual start
      # only.
      oxbow-dev = removeAttrs (mkOxbowService {
        description = "oxbow window manager (local dev build, debug log)";
        execStart = "${oxbowDevBin}/oxbow --log-level debug";
        conflicts = "oxbow.service";
      }) ["Install"];
    };
  };
}
