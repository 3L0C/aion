{
  lib,
  pkgs,
  ...
}: let
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize; ${pkgs.systemd}/bin/loginctl lock-session";
  display = status: "${pkgs.wlopm}/bin/wlopm --${status} \\*";
  baseTimeout = 900; # 15 minutes
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "wayland-session@river.target";

    events = {
      before-sleep = (display "off") + "; " + lock;
      after-resume = display "on";
    };

    timeouts = [
      # Display off
      {
        timeout = baseTimeout;
        command = display "off";
        resumeCommand = display "on";
      }
      # Lock 60 seconds after display off
      {
        timeout = baseTimeout + 60;
        command = lock;
      }
      {
        timeout = baseTimeout * 2;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
  systemd.user.services.swayidle = lib.custom.scopeServiceToWaylandSession "river" {};
}
