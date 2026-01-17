{
  config,
  lib,
  pkgs,
  ...
}: let
  hasOLED = lib.any (m: m.isOLED or false) config.monitors;
  service = {
    Unit = {
      Description = "wl-gammarelay-rs - Wayland gamma/brightness control daemon";
      Documentation = "https://github.com/MaxVerevkin/wl-gammarelay-rs";
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.wl-gammarelay-rs}";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
in {
  config = lib.mkIf hasOLED {
    home.packages = [pkgs.wl-gammarelay-rs];

    systemd.user.services.wl-gammarelay = lib.custom.mkWaylandService {
      river = service;
      riverdev = service;
    };
  };
}
