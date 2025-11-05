{
  lib,
  pkgs,
  ...
}: let
  loginctl = "${pkgs.systemd}/bin/loginctl";

  baseTimeout = 900; # 15 minutes
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "wayland-session@river.target";

    events = [
      {
        event = "before-sleep";
        command = "${loginctl} lock-session";
      }
      {
        event = "after-resume";
        command = "${pkgs.wlopm}/bin/wlopm --on \\*";
      }
    ];

    timeouts = [
      {
        timeout = baseTimeout;
        command = "${loginctl} lock-session";
      }
      {
        timeout = baseTimeout + 60;
        command = "${pkgs.wlopm}/bin/wlopm --off \\*";
        resumeCommand = "${pkgs.wlopm}/bin/wlopm --on \\*";
      }
    ];
  };
  systemd.user.services.swayidle = lib.custom.scopeServiceToWaylandSession "river" {};
}
