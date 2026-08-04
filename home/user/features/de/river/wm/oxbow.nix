{lib, ...}: let
  oxbowDevBin = "/home/user/Projects/oxbow-dev/result/bin";

  mkOxbowService = {
    logLevel,
    conflicts,
  }:
    lib.custom.mkWaylandService {
      river = {
        Unit = {
          Description = "oxbow window manager for River 0.4.x (${logLevel} log level)";
          Conflicts = [conflicts];
        };

        Service = {
          Type = "simple";
          ExecStart = "${oxbowDevBin}/oxbow --log-level ${logLevel}";
          Restart = "on-failure";
          RestartSec = "3s";
        };
      };
    };
in {
  home.sessionPath = [oxbowDevBin];

  systemd.user.services = {
    oxbow = mkOxbowService {
      logLevel = "info";
      conflicts = "oxbow-debug.service";
    };
    oxbow-debug = removeAttrs (mkOxbowService {
      logLevel = "debug";
      conflicts = "oxbow.service";
    }) ["Install"];
  };
}
