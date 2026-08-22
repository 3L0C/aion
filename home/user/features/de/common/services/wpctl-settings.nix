{
  lib,
  pkgs,
  ...
}: {
  systemd.user.services.wpctl-settings = lib.custom.mkWaylandService {
    river = {
      Unit = {
        Description = "Configure WirePlumber Bluetooth settings";
      };

      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.wireplumber}/bin/wpctl settings --save bluetooth.autoswitch-to-headset-profile false";
        Slice = "background-graphical.slice";
        Restart = "on-failure";
        RestartSec = 2;
      };
    };
  };
}
