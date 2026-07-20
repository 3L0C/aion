{lib, ...}: let
  ocdwmDevBin = "/home/user/Projects/ocdwm-dev/result/bin";

  mkOcdwmService = {
    logLevel,
    conflicts,
  }:
    lib.custom.mkWaylandService {
      river = {
        Unit = {
          Description = "ocdwm window manager for River 0.4.x (${logLevel} log level)";
          Conflicts = [conflicts];
        };

        Service = {
          Type = "simple";
          ExecStart = "${ocdwmDevBin}/ocdwm --log-level ${logLevel}";
          Restart = "on-failure";
          RestartSec = "3s";
        };
      };
    };
in {
  home.sessionPath = [ocdwmDevBin];

  systemd.user.services = {
    ocdwm = mkOcdwmService {
      logLevel = "info";
      conflicts = "ocdwm-debug.service";
    };
    ocdwm-debug = removeAttrs (mkOcdwmService {
      logLevel = "debug";
      conflicts = "ocdwm.service";
    }) ["Install"];
  };
}
