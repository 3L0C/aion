{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.ocdwm];

  systemd.user.services.ocdwm = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "ocdwm window manager for River 0.4.x";
      };

      Service = {
        Type = "simple";
        ExecStart = lib.getExe pkgs.ocdwm;
        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
  };
}
