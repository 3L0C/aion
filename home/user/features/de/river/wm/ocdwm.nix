{lib, ...}: let
  ocdwmDevBin = "/home/user/Projects/ocdwm-dev/result/bin";
in {
  home.sessionPath = [ocdwmDevBin];

  systemd.user.services.ocdwm = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "ocdwm window manager for River 0.4.x";
      };

      Service = {
        Type = "simple";
        ExecStart = "${ocdwmDevBin}/ocdwm";
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
  };
}
